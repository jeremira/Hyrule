class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user,    only: [:index, :show, :edit, :update]
  before_action :set_account, only: [:index, :show, :edit]#create account if none


  def index #root page
  end

  def show #profile page
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Changements enregistrés.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html {
          flash.now[:alert] = "Les changements n'ont pas pu être enregistrés"
          render :edit
        }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, account_attributes: [:id, :name, :about, :info])
    end

    def set_user
      @user = current_user
    end

    def set_account
      @account = current_user.account || current_user.build_account()
    end

end
