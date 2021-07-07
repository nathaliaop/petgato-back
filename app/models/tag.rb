class Tag < ApplicationRecord
  has_and_belongs_to_many :posts

  validates :name, :description, presence: true
end