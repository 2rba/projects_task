# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Project do
  it 'is valid with name and status' do
    expect(described_class.new(name: 'test', status: 'new')).to be_valid
  end

  it 'is invalid without name' do
    expect(described_class.new(name: '', status: 'new')).to be_invalid
  end

  it 'is invalid with wrong status' do
    expect(described_class.new(name: 'test', status: 'err')).to be_invalid
  end

  describe '#update_status!' do
    let(:project) { described_class.create!(name: 'test', status: 'new') }

    it 'updates project status' do
      project.update_status!('in progress')
      expect(project.status).to eq('in progress')
    end

    it 'creates project_change' do
      expect { project.update_status!('in progress') }.to change { project.project_changes.count }.by(1)
      expect(project.project_changes.last.old_status).to eq('new')
      expect(project.project_changes.last.new_status).to eq('in progress')
    end

    context 'with invalid status' do
      it 'does not update project status' do
        expect { project.update_status!('err') }.to raise_error(ActiveRecord::RecordInvalid)
          .and(not_change { project.status })
          .and(not_change { ProjectChange.count })
      end
    end
  end
end
