# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    if params[:q] || params[:categories] || params[:publishers]
      perform_search
    else
      @pagy, @articles = pagy(Article.all.includes(:publishers, :tags, :category))
    end
  end

  private

  def perform_search
    return search_by_postgres if params[:not_es_query]

    search_by_elasticsearch
  end

  def search_by_postgres
    @pagy, @articles = pagy(ArticlesQuery.new(params).call.includes(:publishers, :tags, :category))
  end

  def search_by_elasticsearch
    records = ArticlesEsQuery.new(params).call
    @pagy, @articles = pagy_elasticsearch_rails(records)
  end
end
