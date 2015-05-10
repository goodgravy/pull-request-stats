# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = [
  User.create(id: 2, login: 'goodgravy'),
  User.create(id: 42, login: 'ekosz'),
  User.create(id: 12, login: 'troq'),
  User.create(id: 944, login: 'deepthawtz'),
]

PullRequest.create(
  id: 1000,
  url: 'https://github.com/teespring/rails-teespring/pull/1234', number: 1234, state: :closed,
  created_at: Time.new(2015, 1, 1, 0, 0, 0),
  updated_at: Time.new(2015, 1, 10, 9, 1, 0),
  closed_at:  Time.new(2015, 1, 10, 9, 1, 0),
  merged_at:  Time.new(2015, 1, 10, 9, 1, 0),
  user: users[0],
)
PullRequest.create(
  id: 1220,
  url: 'https://github.com/teespring/rails-teespring/pull/1243', number: 1243, state: :closed,
  created_at: Time.new(2015, 2, 1, 0, 0, 0),
  updated_at: Time.new(2015, 2, 10, 9, 1, 0),
  closed_at:  Time.new(2015, 2, 10, 9, 1, 0),
  merged_at:  nil,
  user: users[1],
)
PullRequest.create(
  id: 1670,
  url: 'https://github.com/teespring/rails-teespring/pull/1341', number: 1341, state: :open,
  created_at: Time.new(2015, 3, 1, 0, 0, 0),
  updated_at: Time.new(2015, 3, 10, 9, 1, 0),
  closed_at:  nil,
  merged_at:  nil,
  user: users[2],
)
PullRequest.create(
  id: 2170,
  url: 'https://github.com/teespring/rails-teespring/pull/1478', number: 1478, state: :open,
  created_at: Time.new(2015, 3, 1, 0, 0, 0),
  updated_at: Time.new(2015, 3, 1, 9, 1, 0),
  closed_at:  nil,
  merged_at:  nil,
  user: users[3],
)
