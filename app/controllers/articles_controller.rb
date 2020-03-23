# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    @pagy, @articles = pagy(Article.all)
  end
end
