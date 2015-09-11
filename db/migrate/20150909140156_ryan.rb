class Ryan < ActiveRecord::Migration
  def change
  create_table   :todos do |t|
      t.string   :name
      t.string   :tasks
      t.boolean  :completion_level
    end
  end
end
