class AccountsController < ApplicationController
  before_action :set_account, only: [:edit, :update, :create ]

  def edit
  end

  def update
  end

  def create
  end

  private
    def account_params
      params.require(:account).permit(:name, :about)
    end

    def set_account
      @account = current_user.account
    end

end
