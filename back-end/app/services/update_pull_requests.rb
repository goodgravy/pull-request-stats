class UpdatePullRequests
  def self.[]
    new.execute
  end

  def execute
    prs = Github::PullRequest.since(interested_in_prs_since)
    prs.each do |pr|
      upsert_pr(pr.except('user'))
      upsert_user(pr['user'])
    end
  end

  private

  def upsert_pr(params)
    upsert(PullRequest, params)
  end

  def upsert_user(params)
    upsert(User, params)
  end

  def upsert(klass, params)
    existing_obj = klass.find?(params['id'])

    if existing_obj
      existing_obj.update(params.except('id'))
    else
      klass.create(params)
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

