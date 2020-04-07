# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def format_publishers(publishers)
    publishers.map(&:name).join(', ')
  end
end
