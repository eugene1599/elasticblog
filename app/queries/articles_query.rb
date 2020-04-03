# frozen_string_literal: true

class ArticlesQuery
  def initialize(params = {}, relation = Article.all)
    @relation = relation
    @params = params
  end

  def call
    scope = search_by_text(relation)
    scope = filter_by_category(scope)
    scope = filter_by_publishers(scope)
    scope.order(created_at: :desc)
  end

  private

  attr_reader :params, :relation

  def search_by_text(scope)
    return scope if params[:q].blank?

    scope
      .joins(:tags)
      .where('articles.body LIKE :query OR articles.title LIKE :query OR tags.name LIKE :query', query: "%#{params[:q]}%")
  end

  def filter_by_category(scope)
    categories = params[:categories].to_a.reject(&:blank?)
    return scope if categories.blank?

    scope.where(category_id: categories)
  end

  def filter_by_publishers(scope)
    publishers = params[:publishers].to_a.reject(&:blank?)
    return scope if publishers.blank?

    scope.joins(:publishers).where(publishers: { id: publishers })
  end
end
