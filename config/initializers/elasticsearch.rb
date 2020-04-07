# frozen_string_literal: true

if ENV['ELASTICSEARCH_HOST']
  Article.__elasticsearch__client = ElasticSearch::Client.new(host: ENV['ELASTICSEARCH_HOST'])
end
