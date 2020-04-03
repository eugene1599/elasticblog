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

  def formatted_publishers
    publishers.pluck(:name).join(', ')
  end

  def as_indexed_json(*)
    as_json(include: { tags: { only: :name }, publishers: { only: %i[id name] } })
  end
end
