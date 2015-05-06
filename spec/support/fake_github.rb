require 'sinatra/base'

class FakeGitHub < Sinatra::Base
  get '*' do
    sorted_query_string = request.env['rack.request.query_hash'].sort.to_h.to_query
    gh_json_response(200, [request.path, sorted_query_string].join('?'))
  end

  private

  def gh_json_response(status_code, path)
    content_type :json
    status status_code
    headers fixture_headers(status_code, path)
    fixture_body(status_code, path)
  end

  def fixture_body(status_code, path)
    fixture_file = File.join(fixture_directory(status_code, path), 'body.txt')
    File.open(fixture_file, 'rb').read
  end

  def fixture_headers(status_code, path)
    fixture_file = File.join(fixture_directory(status_code, path), 'headers.txt')
    header_tuples = File.readlines(fixture_file)
      .map { |line| line.gsub(/\A< /, '') }
      .map { |line| line.partition(': ') }
      .select { |key, _, value| key.present? && value.present? }
      .map { |key, _, value| [key.to_sym, value] }

    Hash[*header_tuples.flatten]
  end

  def fixture_directory(status_code, path)
    File.join(
      Rails.root,
      'fixtures',
      'fake_github',
      status_code.to_s + path.gsub('/', '_'),
    )
  end
end
