class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
    	t.integer :user_id
    	t.string :name
    	t.string :type
    	t.datetime :due_date
    	t.integer :parent_id
    	t.integer :time_estimate
    	t.boolean :recurring
    	t.integer :recurring_frequency
      t.timestamps
    end
  end
end