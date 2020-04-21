class UsersController < ApplicationController
  # GET /users
  def index
    @users = User.all.order(:updated_at).reverse_order
    render json: @users, status: :ok
  end

  # GET /groups_by_user/{id}
  def showGroups
    find_user
    if @user != nil
      render json: @user.user_groups.select(:group_id), status: :ok
    end
  end

  # GET /events_by_user/{id}
  def showEvents
    find_user
    if @user != nil
      render json: @user.user_events.select(:event_id), status: :ok
    end
  end

  # GET /users/{id}
  def show
    find_user
    if @user != nil
      render json: @user, status: :ok
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: "created user with name " + @user.name + " and cellphone " + @user.phone_number, status: :created
    else
      render json: { errors: @user.errors.full_messages},
             status: :bad_request
    end
  end

  # PUT /users/{id}
  def update
    find_user
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages },
             status: :not_acceptable
    else
      render json: "user named " + @user.name + " updated succesfully", status: :accepted
    end
  end

  # DELETE /users/{id}
  def destroy
    find_user
    if @user != nil
      render :text => "user " + @user.name.to_s + " successfully deleted", status: :no_content
      @user.destroy
    end
  end

  private

  def find_user
    @user = User.find_by_id!(params[:_id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(
        :name, :phone_number, :age, :career, :status
    )
  end
end
