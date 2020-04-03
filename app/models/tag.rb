# frozen_string_literal: true

class Tag < ApplicationRecord
  has_and_belongs_to_many :articles # rubocop:disable Rails/HasAndBelongsToMany

  validates :name, presence: true, uniqueness: true
end
