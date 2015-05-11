module JsonHelpers
  def json_data
    json_body['data']
  end

  def json_errors
    json_body['errors']
  end

  def json_body
    @json_body ||= JSON.parse(response.body)
  end
end

RSpec.configure do |c|
  c.include JsonHelpers, type: :request
end
