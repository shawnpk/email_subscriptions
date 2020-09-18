class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_task, only: [:edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def edit
  end

  def create
    @task = @project.tasks.new(task_params)

    if @task.save
      redirect_to @project, notice: 'Task was successfully created.'
    else
      render @project
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @project, notice: 'Task was successfully updated.'
    else
      render @project
    end
  end

  def destroy
    @task.destroy
    redirect_to projects_url, notice: 'Task was successfully destroyed.'
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_task
      @task = Task.find(params[:id])
    end


    def task_params
      params.require(:task).permit(:body, :project_id, :complete)
    end
end
