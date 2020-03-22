class Tag < ApplicationRecord
  has_many :articles, through: :article_tag

  validates :name, presence: true, uniqueness: true
end
