# frozen_string_literal: true

class Article < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  extend Pagy::Search

  belongs_to :user
  belongs_to :category
  has_and_belongs_to_many :tags, after_add: [->(article, _) { article.__elasticsearch__.index_document }], # rubocop:disable Rails/HasAndBelongsToMany
                                 after_remove: [->(article, _) { article.__elasticsearch__.index_document }]
  has_and_belongs_to_many :publishers # rubocop:disable Rails/HasAndBelongsToMany

  validates :title, :body, presence: true

  settings do
    mappings do
      indexes :title, type: :text
      indexes :body, type: :text
      indexes :category_id, type: :long
      indexes :tags, type: :object do
        indexes :name, type: :text
      end
      indexes :publishers, type: :object do
        indexes :id, type: :long
      end
      indexes :category, type: :object, enabled: false
    end
  end

  def as_indexed_json(*)
    as_json(
      include: {
        tags: { only: :name },
        publishers: { only: %i[id name] },
        category: { only: :name }
      }
    )
  end
end
