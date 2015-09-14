class CreateTodoTable < ActiveRecord::Migration
  def change
    create_table   :todos do |t|
        t.string   :name
        t.string   :tasks
        t.string   :completion_level, default: 'no'
    end
  end
end
