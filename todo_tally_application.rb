require 'faraday'

class TodoTallyApplication
  URL = 'https://jsonplaceholder.typicode.com/todos'

  def call(env)
    body = []
    status = 200

    case env['REQUEST_PATH']
    when '/todo/completed_items'
      call_todo_api() do |response|
        body << display_completed_items(response)
      end
    when '/todo/most_completed_items'
      call_todo_api() do |response|
        body << display_most_completed_items(response)
      end
    else
      status = 404
    end
    [status, {'Content-type' => 'text/html; charset=UTF-8'}, body]
  rescue StandardError => e
    [500, {}, e.message]
  end

  private

  def completed_items(to_do_items)
    totals = {}
    to_do_items.each do |item|
      if totals[item['userId']].nil?
        totals[item['userId']] = {
            total_completed: item['completed'] ? 1 : 0
        }
      else
        totals[item['userId']][:total_completed] += (item['completed'] ? 1 : 0)
      end
    end
    totals
  end

  def display_completed_items(response)
    to_do_items = JSON.parse(response.body)
    completed_html = ""
    completed_items(to_do_items).each do |item|
      completed_html << "USER #{item[0]}: #{item[1][:total_completed]}<br><br>"
    end

    most_completed_html = ""
    most_completed_items(to_do_items).each do |item|
      most_completed_html << "USER #{item[0]}: #{item[1][:total_completed]}<br><br>"
    end

    <<-HTML
      <html>
      <body>
      <h1>Completed Todos by User</h1>
      #{completed_html}
      <br>
      <h1>Most Completed</h1>
      #{most_completed_html}
      </body>
      </html>
    HTML
  end

  def most_completed_items(to_do_items)
    current_max = 0
    user_with_max_completed = [] # there could be a tie for max
    completed_items(to_do_items).each do |item|
      if item[1][:total_completed] >= current_max
        current_max = item[1][:total_completed]
        user_with_max_completed << item
      end
    end
    # this ensures the first index is deleted if : total_completed is less that max.
    # It resolves the first item being counted as max on first loop in each block.
    user_with_max_completed.delete_if { |item| item[1][:total_completed] < current_max }
    user_with_max_completed
  end

  def display_most_completed_items(response)
    to_do_items = JSON.parse(response.body)
    list_html = ""
    most_completed_items(to_do_items).each do |item|
      list_html << "USER #{item[0]}: #{item[1][:total_completed]}<br><br>"
    end
    <<-HTML
      <html>
      <body>
      <h1>Most Completed</h1>
      <br>
      #{list_html}
      </body>
      </html>
    HTML
  end

  def call_todo_api()
    response = Faraday.get(URL)
    if(response.status == 200)
      yield response
    else
      raise "Failed request at #{URL} with status #{response.status}"
    end
  end
end