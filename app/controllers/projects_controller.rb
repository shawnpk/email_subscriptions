class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = current_user.projects.all
  end

  def show
    @task = Task.new
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project      = Project.new(project_params)
    @project.user = current_user
    
    respond_to do |format|
      if @project.save
        (@project.users.uniq - [current_user]).each do |user|
          ProjectMailer.with(project: @project, user: user, author: current_user).user_added_to_project.deliver_later
        end
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_project
      @project = Project.find(params[:id])
    end


    def project_params
      params.require(:project).permit(:title, :description, user_ids: [])
    end
end
