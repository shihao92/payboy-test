class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:update, :update_password]

  def update
    if @user.update(user_params)
      render json: { message: 'User updated successfully', user: @user }, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update_password
    if @user.update_with_password(password_update_params)
      render json: { message: 'Password updated successfully' }, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def password_update_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end