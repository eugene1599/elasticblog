# frozen_string_literal: true

class ArticlesEsQuery
  def initialize(params)
    @params = params
  end

  def call
    Article.pagy_search(build_full_query)
  end

  private

  attr_reader :params

  def build_full_query
    build_query(params[:q]).deep_merge(build_filter(params))
  end

  def build_query(query) # rubocop:disable Metrics/MethodLength
    {
      query: {
        bool: {
          should: {
            multi_match: {
              query: query.presence || '*',
              type: 'phrase_prefix',
              fields: ['title', 'body', 'tags.name']
            }
          }
        }
      }
    }
  end

  def build_filter(params) # rubocop:disable Metrics/MethodLength
    publishers = params[:publishers].to_a.reject(&:blank?)
    categories = params[:categories].to_a.reject(&:blank?)

    filters = []
    filters << { terms: { category_id: categories } } if categories.present?
    filters << { terms: { 'publishers.id': publishers } } if publishers.present?

    return {} if filters.blank?

    {
      query: {
        bool: {
          filter: filters
        }
      }
    }
  end
end
