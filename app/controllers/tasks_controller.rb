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

  # POST /complete
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
      Task.destroy(id);
      Task.update(parent_id, total_time: new_total)
    else
      @tasks = Task.where(parent_id: id)
      @tasks.each do |t|
        Task.update(t.id, is_completed: true)
      end
      Task.destroy(id);
    end
  end

    # POST /update
  def update
    puts "PARAMS #{params[:task_id]} #{params[:due_date]} #{params[:time_estimate]} #{params[:name]}"
    @task = Task.update(params[:task_id], due_date: params[:due_date], time_estimate: params[:time_estimate], name: params[:name]);
    render json: {
        message: 'updated',
        task: @task,
      }
  end

  private
  def tasks(user, parent)  
      @parents = Task.where(user_id: user, parent_id: 0, is_completed: false)
      @sorted = @parents.sort_by { |parent| parent["due_date"].split('/').reverse }
      @sorted.each do |task|
        task.due_date = Date.parse(task.due_date)
      end
      @children =  Task.where(user_id: user, is_completed: false).where.not(parent_id: 0).sort_by{ |child| child["time_estimate"] };
      
      render json: {
        message: 'got tasks',
        parentTasks: @sorted,
        childTasks: @children
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
