class AccountsController < ApplicationController

  def new
  end

  def edit
    @account = current_user.account
  end

  def update
    @account = current_user.account
    if @account.update(account_params)
      flash[:message] = "Profile saved !"
      redirect_to user_path(current_user)
    else
      flash[:error] = "Could not save the change !"
      render 'edit'
    end
  end

  def create
    @account = current_user.build_account(account_params)

    if @account.save
      flash[:message] = "Profile saved !"
      redirect_to user_path(current_user)
    else
      flash[:error] = "Error, could not save profile !"
      redirect_to user_path(current_user)
    end
  end

  def destroy
  end

  private
    def account_params
      params.require(:account).permit(:name, :about)
    end

end
