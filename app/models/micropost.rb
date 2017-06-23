class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader #图像上传程序
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :picture_size

  #验证上传图像的大小
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB" )
    end
  end
end
