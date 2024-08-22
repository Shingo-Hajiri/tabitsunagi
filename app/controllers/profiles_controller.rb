class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[edit update email_edit]

  def show; end

  def edit
    @user.build_profile_image unless @user.profile_image
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path, notice: t('.success')
    else
      flash.now[:alert] = t('.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  def email_edit; end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(
      :name, :email,
      profile_image_attributes: %i[id avatar]
    )
  end
end
