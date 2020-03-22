class ArticlePublisher < ApplicationRecord
  belongs_to :article
  belongs_to :tag
end
