# frozen_string_literal: true
class ProjectChangesController < ApplicationController
  def create
    project_change = ProjectChange.new(project_params)

    if project_change.save
      redirect_to project_change.project, notice: 'done'
    else
      redirect_to project_change.project, notice: 'failed'
    end
  end

  private

  def project_params
    project_change_params = params.require(:project_change)
    project_change_params.permit(:comment, :status).merge(project_id: project_change_params.require(:project_id))
  end
end
