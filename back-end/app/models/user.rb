class User
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  field :id, :type => Integer, :primary_key => true
  field :login, :type => String

  has_many :pull_requests
end
