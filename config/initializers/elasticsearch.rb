# frozen_string_literal: true

if ENV['ELASTICSEARCH_HOST']
  Elasticsearch::Model.client = Elasticsearch::Client.new(host: ENV['ELASTICSEARCH_HOST'])
end
