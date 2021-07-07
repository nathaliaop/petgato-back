class Comment < ApplicationRecord
    belongs_to :post
    belongs_to :user

    has_many :replies

    has_many :reports, as: :reportable
end
