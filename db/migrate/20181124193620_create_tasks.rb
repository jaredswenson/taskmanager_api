class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
    	t.integer :user_id
    	t.string :name
    	t.string :due_date, :null => true
    	t.integer :parent_id, :null => true
    	t.integer :time_estimate, :null => true
    	t.boolean :recurring
    	t.integer :recurring_frequency, :null => true
      t.boolean :is_completed
      t.integer :total_time, :null => true
      t.integer :days_remaining, :null => true
      t.timestamps
    end
  end
end