class UsersController < ApplicationController

  before_action :authenticate_user!

  def index
    @user = current_user
    @trips = @user.trips
  end

  def show
    @user = current_user
    @account = @user.account || @user.build_account
  end

  def edit
    @user = current_user
    @account = current_user.account || @user.build_account
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:message] = "Profile saved !"
      redirect_to user_path(current_user)
    else
      flash[:error] = "Could not save the change !"
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, account_attributes: [:id, :name, :about])
    end

end
