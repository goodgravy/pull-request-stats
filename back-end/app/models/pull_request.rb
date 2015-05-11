class PullRequest
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  field :id, :type => Integer, :primary_key => true
  field :url, :type => String
  field :number, :type => Integer
  field :state, :type => String, :index => true
  field :created_at, :type => Time, :index => true
  field :updated_at, :type => Time, :index => true
  field :closed_at, :type => Time, :index => true
  field :merged_at, :type => Time, :index => true

  belongs_to :user
end
