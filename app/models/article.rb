# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_and_belongs_to_many :tags # rubocop:disable Rails/HasAndBelongsToMany
  has_and_belongs_to_many :publishers # rubocop:disable Rails/HasAndBelongsToMany

  validates :title, :body, presence: true

  def formatted_publishers
    publishers.pluck(:name).join(', ')
  end
end
