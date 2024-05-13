class PostImage < ApplicationRecord

  belongs_to :user
  has_one_attached :image
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

acts_as_taggable

  def self.search(title)
    PostImage.where(title: title)
  end

  def get_image
   unless image.attached?
    file_path = Rails.root.join('app/assets/images/neko-kage01.jpg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
   end
   image
  end

  def favorited_by?(user)
   favorites.exists?(user_id: user.id)
  end
end
