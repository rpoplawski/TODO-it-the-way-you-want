require_relative "../db/setup"
require_relative '../lib/all'

todo_list = List.new

todo_list.get_tasks

todo_list.display_all_todos

todo_list.remove_todos
