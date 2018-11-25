class TasksController < ApplicationController
	# POST /create
  def create
  	puts task_params
   # @task = Task.create(task_params)
   # if @task.save
   # 	puts "TAAAAASK"
   #  response = { message: 'Task created successfully'}
   #  render json: response, status: :created 
   # else
   #  render json: @tasks.errors, status: :bad
   # end 
  end

  private
	
  def task_params
    params.permit(
      :user_id
      :name
      :type
      :due_date
      :parent_id
      :time_estimate
      :recurring
      :recurring_frequency
    )
  end
end
