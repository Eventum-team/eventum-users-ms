class UserGroupsController < ApplicationController
  # GET /user_groups
  def index
    @userGroups = UserGroup.all
    render json: @userGroups, status: :ok
  end

  # GET /user_groups/{user_id}/{group_id}
  def show
    find_user_group
    if @userGroup != nil
      render json: @userGroup, status: :ok
    end

  end

  # GET /user_groups{group_id}
  def showUsers
    targetGroups = User.joins(:user_groups).where(user_groups:{group_id: params[:group_id]})
    if targetGroups != nil
      render json: targetGroups, status: :ok
    end
  end

  # GET /admin_groups{group_id}
  def showAdmins
    targetGroups = User.joins(:user_groups).where(user_groups: {group_id: params[:group_id], status: "admin"})
    if targetGroups != nil
      render json: targetGroups, status: :ok
    end
  end

  # POST /user_groups
  def create
    @userGroup = UserGroup.new(user_group_params)
    if @userGroup.save
      render json: @userGroup, status: :created
    else
      render json: { errors: @userGroup.errors.full_messages},
             status: :bad_request
    end
  end

  # PUT /user_groups/{user_id}/{group_id}
  def update
    find_user_group
    unless @userGroup.update(user_group_update_params)
      render json: { errors: @userGroup.errors.full_messages },
             status: :not_acceptable
    else
      render json: @userGroup, status: :accepted
    end
  end

  # DELETE /user_groups/{user_id}/{group_id}
  def destroy
    find_user_group
    if @userGroup != nil
      render :text => "user " + @userGroup.user_id.to_s + "not related to the" + @userGroup.group_id.to_s + " group anymore", status: :no_content
      @userGroup.destroy
    end
  end

  private

  def find_user_group
    @userGroup = UserGroup.find_by!(user_id: params[:user_id], group_id: params[:group_id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User-Group association not found' }, status: :not_found
  end

  def user_group_params
    params.permit(
        :user_id, :group_id, :status
    )
  end

  def user_group_update_params
    params.permit(
        :status
    )
  end
end
