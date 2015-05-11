json.errors [nil] do
  json.status @status
  json.title @error.to_s
  json.detail @error.backtrace
end
