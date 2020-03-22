class Publisher < ApplicationRecord
  has_many :articles, through: :article_publisher

  validates :name, presence: true, uniqueness: true
end
