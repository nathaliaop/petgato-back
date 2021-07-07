class Post < ApplicationRecord
  has_and_belongs_to_many :tags

  has_one_attached :banner_image
  has_rich_text :content

  validates :title, :banner_image, :views, :content, presence: true
end
