class UpdatePullRequests
  def self.[]
    new.execute
  end

  def execute
    prs = Github::PullRequest.since(interested_in_prs_since)
    prs.each { |pr| upsert(pr) }
  end

  private

  def upsert(pr_params)
    existing_pr = PullRequest.find?(pr_params['id'])
    if existing_pr
      existing_pr.update(pr_params.except('id'))
    else
      PullRequest.create(pr_params)
    end
  end

  def interested_in_prs_since
    youngest_closed_pr = PullRequest.where(state: 'closed').order_by(closed_at: :desc).first
    if youngest_closed_pr.present?
      youngest_closed_pr.closed_at
    else
      DateTime.new(1970, 1, 1, 0, 0, 0)
    end
  end
end

