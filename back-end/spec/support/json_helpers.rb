module JsonHelpers
  def json_data
    @json_data ||= JSON.parse(response.body)['data']
  end
end

RSpec.configure do |c|
  c.include JsonHelpers, type: :controller
end
