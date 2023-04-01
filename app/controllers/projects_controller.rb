# frozen_string_literal: true
class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update]

  def index
    @projects = Project.all.order(created_at: :desc).strict_loading.includes(:project_changes)
  end

  def show; end

  def new
    @project = Project.new
  end

  def edit; end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @project.update_status!(params.require(:project).require(:status))
    redirect_to @project, notice: 'Project was successfully updated.'
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = e.message
    render :edit, status: :unprocessable_entity
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :status)
  end
end
