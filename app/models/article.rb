class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :tags, through: :article_tag
  has_many :publishers, through: :article_publisher

  validates :title, :body, precence: true
end
