module Github
  class PullRequest
    def self.since(time)
      prs_resp = Github.client.get(
        'https://api.github.com/repos/teespring/rails-teespring/pulls',
        params: { per_page: 50, state: 'all' }
      )

      prs = to_json(prs_resp)

      while later_than(prs.last['created_at'], time)
        prs_resp = get_next(prs_resp)
        prs.concat(to_json(prs_resp))
      end

      prs.take_while { |pr| later_than(pr['created_at'], time) }
    end

    private

    def self.get_next(resp)
      Github.client.get(Github.header_links(resp)[:next])
    end

    def self.to_json(http_resp)
      fail http_resp.to_s if http_resp.status_code != 200

      JSON.parse(http_resp.to_s)
    end

    def self.later_than(pr_created_at, time)
      DateTime.parse(pr_created_at) > time
    end
  end

  private

  def self.client
    @client = HTTP.basic_auth(
      user: ENV['GITHUB_ACCESS_TOKEN'],
      pass: 'x-oauth-basic'
    )
  end

  def self.header_links(resp)
    links = ( resp.headers['Link'] || '' ).split(', ').map do |link|
      href, name = link.match(/<(.*?)>; rel="(\w+)"/).captures

      [name.to_sym, href]
    end

    Hash[*links.flatten]
  end
end
