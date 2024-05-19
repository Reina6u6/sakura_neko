class UsersController < ApplicationController
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
end
