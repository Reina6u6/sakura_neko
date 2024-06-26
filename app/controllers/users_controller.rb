class UsersController < ApplicationController
 before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.page(params[:page])
    @favorite_post_images = current_user.favorite_post_images
  end

  def edit
   @user = User.find(params[:id])
  end

  def update
   @user = User.find(params[:id])
   @user.update(user_params)
   redirect_to user_path
  end

 private

 def user_params
   params.require(:user).permit(:name, :profile_image)
 end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

end
