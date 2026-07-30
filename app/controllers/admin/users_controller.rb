module Admin
  class UsersController < ApplicationController
    before_action :set_user, only: %i[edit update destroy]

    def index
      @pagy, @users = pagy(:offset, authorize(policy_scope(User)))
    end

    def edit; end

    def update
      respond_to do |format|
        if @user.update(permitted_attributes(@user))
          format.html { redirect_to admin_users_path, notice: "User has been updated." }
        else
          format.html { render :edit, status: :unprocessable_content }
        end
      end
    end

    def destroy
      @user.destroy!
      redirect_to admin_users_path
    end

    private

    def set_user
      @user = User.find(params.expect(:id))
      authorize @user
    end
  end
end
