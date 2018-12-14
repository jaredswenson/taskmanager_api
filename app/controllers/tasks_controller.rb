class TasksController < ApplicationController
	# POST /create
  def create
     @task = Task.create(task_params)
     
     if @task[:parent_id] != 0
       @parent = Task.find(@task[:parent_id])
       # time
       parent_time = @parent[:total_time]
       child_time = @task[:time_estimate]
       new_total = parent_time + child_time
       Task.update(@parent.id, total_time: new_total)
     else
      date = @task[:due_date].to_date
      days_left = date - Date.today
      @task[:days_remaining] = days_left
     end

     if @task.save
      response = { message: 'Task created successfully'}
      render json: response, status: :created 
     else
      render json: @tasks.errors, status: :bad
     end 
  end

  # POST /get
  def get
    tasks params[:user_id], params[:parent_id]
  end

  # POST /get
  def complete
    id = params[:task_id]
    @task = Task.find(id)
    if @task[:parent_id] != 0
      parent = @task[:parent_id]
      @parent = Task.find(parent)
      parent_id = @parent[:id]
      # time
      child_time = @task[:time_estimate]
      parent_time = @parent[:total_time]
      new_total = parent_time - child_time
      Task.update(id, is_completed: true)
      Task.update(parent_id, total_time: new_total)
    else
      @tasks = Task.where(parent_id: id)
      @tasks.each do |t|
        Task.update(t.id, is_completed: true)
      end
      Task.update(id, is_completed: true)
    end
    
    
  end

  private
  def tasks(user, parent)        
      render json: {
        message: 'got tasks',
        tasks: Task.where(user_id: user)
      }
  end

	private
  def task_params
    params.permit(
      :user_id,
      :name,
      :due_date,
      :parent_id,
      :time_estimate,
      :total_time,
      :is_completed,
      :recurring,
      :recurring_frequency
    )
  end
end
