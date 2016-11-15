class Micropost < ActiveRecord::Base
  belongs_to :user
  
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
  
  # carrierwaveと関連付け
  mount_uploader :picture, PictureUploader
  
end
