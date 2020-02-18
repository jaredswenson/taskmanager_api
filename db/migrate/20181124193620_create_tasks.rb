class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
    	t.integer :user_id
      t.string :name
      t.string :category
      t.boolean :is_completed
      t.timestamps
    end
  end
end