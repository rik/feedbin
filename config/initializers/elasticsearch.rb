options = {
  log: Rails.env.development?,
  transport_options: {
    ssl: { verify: false }
  }
}
Elasticsearch::Model.client = Elasticsearch::Client.new(options)
if Rails.env.development?
  Elasticsearch::Model.client.transport.tracer = ActiveSupport::Logger.new('log/elasticsearch.log')
  Entry.__elasticsearch__.create_index! rescue nil
end