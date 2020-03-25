# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    @pagy, @articles = pagy(ArticlesQuery.new(params).call.includes(:publishers))
  end
end
