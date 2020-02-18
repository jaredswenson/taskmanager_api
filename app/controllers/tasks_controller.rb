class TasksController < ApplicationController
	# POST /create
  def create
     @task = Task.create(task_params)

     if @task.save
      response = { message: 'Task created successfully'}
      render json: response, status: :created 
     else
      render json: @tasks.errors, status: :bad
     end 
  end

  # POST /get
  def get
    tasks params[:user_id], params[:is_completed]
  end

  # POST /categories
  def categories
    @categories = Category.all()
    render json: {
        message: 'got categories',
        categories: @categories
      }
  end

  # POST /update
  def update
    @task = Task.update(params[:task_id], name: params[:name], is_completed: params[:is_completed]);
    render json: {
        message: 'updated',
        task: @task,
      }
  end

  private
  def tasks(user, is_completed)  
    puts "PARAMS #{user} && #{is_completed}"
      @tasks = Task.where(user_id: user, is_completed: is_completed)
      render json: {
        message: 'got tasks',
        tasks: @tasks
      }
  end

	private
  def task_params
    params.permit(
      :user_id,
      :name,
      :category,
      :is_completed
    )
  end
end
