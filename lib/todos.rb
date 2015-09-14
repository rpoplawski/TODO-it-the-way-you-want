require_relative "../db/setup"
require_relative '../lib/all'


class Todos


  def get_tasks
    name Todos.new

  puts "What task would you like to complete? >"

  puts "What task would you like to add to the 'Todos' list? >"
  task = gets.chomp
  name = task
  name.save

  puts "Your informaton is task: #{name.task} completed: #{name.completed}."

  puts "Your task is: #{name.task} completed: #{name.completed}."
  end

  def todos_list

    list = Todos.select("id", "task").where(completed: "not_completed_yet")
    list.each do |list|

    puts "Todos #{list.id} task #{list.task}"
    end
  end

end
#################

  def add(todo)
    @items << Item.new(todo)
    save
    @items.last
  end

########

  def delete(index)
    todo = @items.delete_at(index.to_i-1)
    save
    todo
  end

  # returns the completed 'todo' item
  def done(index)
    item = @items[index.to_i-1]
    item.context = '@done'
    save
    item
  end

###########
