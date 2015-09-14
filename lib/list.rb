class List

  def initialize
    @new_todo = Todo.new
  end

  def get_tasks
    puts "What task would you like to add to the 'Todos' list? >"
    @new_todo.tasks = gets.chomp
    @new_todo.save

    puts "Your task is: #{@new_todo.tasks} completed: #{@new_todo.completion_level}."
  end

  def display_all_todos
    @all_todos = Todo.where(completion_level: "no")
    puts "Here are all of the todos."
    @all_todos.each_with_index do |todo, index|
      puts "#{index + 1}) #{todo.tasks}, #{todo.completion_level}"
    end
  end

  def remove_todos
    puts "Which todo would you like to remove? Please enter the number of the 'todo'."
    removed_todo = gets.chomp.to_i
    updated_todo = @all_todos[removed_todo - 1]
    puts "The 'todo' has been removed."
    updated_todo.completion_level = "yes"
    updated_todo.save
  end
end
