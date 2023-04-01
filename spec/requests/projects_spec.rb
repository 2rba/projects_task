# frozen_string_literal: true
require 'rails_helper'

RSpec.describe '/projects' do
  let(:project) { Project.create!(name: 'testproject', status: Project::NEW) }

  before { project }

  describe 'GET /index' do
    it 'renders a successful response' do
      get projects_url
      expect(response).to be_successful
      expect(response.body).to have_selector('div', text: 'testproject')
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get project_url(project)
      expect(response).to be_successful
      expect(response.body).to have_selector('div', text: 'testproject')
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_project_url
      expect(response).to be_successful
      expect(response.body).to have_selector('h1', text: 'New project')
      expect(response.body).to have_selector('select', text: 'new')
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      get edit_project_url(project)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      let(:valid_attributes) do
        {
          name: 'testproject2',
          status: Project::NEW
        }
      end

      it 'creates a new Project' do
        expect do
          post projects_url, params: { project: valid_attributes }
        end.to change(Project, :count).by(1)
      end

      it 'redirects to the created project' do
        post projects_url, params: { project: valid_attributes }
        expect(response).to redirect_to(project_url(Project.last))
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        { name: '' }
      end

      it 'does not create a new Project' do
        expect do
          post projects_url, params: { project: invalid_attributes }
        end.not_to change(Project, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post projects_url, params: { project: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { status: Project::IN_PROGRESS }
      end

      it 'updates the requested project' do
        expect do
          patch project_url(project), params: { project: new_attributes }
        end.to change { project.reload.status }.from(Project::NEW).to(Project::IN_PROGRESS)
      end

      it 'logs the change' do
        expect do
          patch project_url(project), params: { project: new_attributes }
        end.to change(ProjectChange, :count).by(1)
        expect(project.project_changes.last.old_status).to eq(Project::NEW)
        expect(project.project_changes.last.new_status).to eq(Project::IN_PROGRESS)
      end

      it 'redirects to the project' do
        patch project_url(project), params: { project: new_attributes }
        expect(response).to redirect_to(project_url(project))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        patch project_url(project), params: { project: { status: 'err' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
