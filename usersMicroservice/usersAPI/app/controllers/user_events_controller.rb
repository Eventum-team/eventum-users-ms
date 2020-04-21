class UserEventsController < ApplicationController
  # GET /user_events
  def index
    @userEvents = UserEvent.all
    render json: @userEvents, status: :ok
  end

  # GET /user_events/{user_id}/{event_id}
  def show
    find_user_event
    if @userEvent != nil
      render json: @userEvent, status: :ok
    end
  end

  # GET /assistant_events/{group_id}
  def showAssistants
    targetEvents = User.joins(:user_events).where(user_events: {event_id: params[:event_id], assistance: true})
    if targetEvents != nil
      render json: targetEvents, status: :ok
    end
  end

  # GET /interested_events/{group_id}
  def showInterested
    targetEvents = User.joins(:user_events).where(user_events: {event_id: params[:event_id], interested: true})
    if targetEvents != nil
      render json: targetEvents, status: :ok
    end
  end

  # POST /user_events
  def create
    @userEvent = UserEvent.new(user_event_params)
    if @userEvent.save
      render json: "added a new user event", status: :created
    else
      render json: { errors: @userEvent.errors.full_messages},
             status: :bad_request
    end
  end

  # PUT /user_events/{user_id}/{event_id}
  def update
    find_user_event
    unless @userEvent.update(user_event_update_params)
      render json: { errors: @userEvent.errors.full_messages },
             status: :not_acceptable
    else
      render json: "updated an user event", status: :accepted
    end
  end

  # DELETE /user_events/{user_id}/{event_id}
  def destroy
    find_user_event
    if @userEvent != nil
      render text: "user " + @userEvent.user_id.to_s + "not related to the" + @userEvent.event_id.to_s + " event anymore", status: :no_content
      @userEvent.destroy
    end
  end

  private

  def find_user_event
    @userEvent = UserEvent.find_by!(user_id: params[:user_id], event_id: params[:event_id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User-Event association not found' }, status: :not_found
  end

  def user_event_params
    params.permit(
        :user_id, :event_id, :assistance, :interested
    )
  end

  def user_event_update_params
    params.permit(
        :assistance, :interested
    )
  end
end
