class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.date :deadline_at
      t.boolean :is_complete

      t.timestamps
    end
    add_index :tasks, [:deadline_at]
    add_index :tasks, [:created_at]
  end
end
