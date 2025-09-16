class UsersController < ApplicationController
  # before_action :authenticate_user!   # optional, forces login
  def edit 
    @user = User.find(params[:id])
  end
  
  def update 
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_url , notice: "User roles updated successfully."
    else
      render :edit , status: :unprocessable_entity
    end
  end 

  def index
    @users = User.order(created_at: :desc)
  end



  private


  def user_params
    params.require(:user).permit(role_ids: [])
  end

  
end
