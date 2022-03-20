require_relative 'todo_tally_application'

# add middleware for default content-type
#use Rack::ContentType, "text/html; charset=UTF-8"
use Rack::Reloader

map('/todo/completed_items') do
  run TodoTallyApplication.new
end

map('/todo/most_completed_items') do
  run TodoTallyApplication.new
end
