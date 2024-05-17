class Public::PostImagesController < ApplicationController
  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    @post_image.save
    redirect_to post_images_path
  end



  def index
   @post_images = PostImage.all
   @tags = PostImage.tag_counts_on(:tags)
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end



  def destroy
    post_image = PostImage.find(params[:id])
    post_image.destroy
    redirect_to post_images_path
  end

  def search
   @post_images = PostImage.where("title LIKE ?", "%#{params[:search]}%")
  end

  def tag
     @post_images = PostImage.tagged_with(params[:tag])
    # if @post_images.empty?
    #   flash[:notice] = "タグに関連する投稿がありません。"
    #   redirect_to post_images_path
    # end

  end



  private

  def post_image_params
    params.require(:post_image).permit(:title, :image, :caption, :tag_list)
  end

end
