# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ProjectChange do
  let(:project) { Project.new(name: 'test', status: 'new') }

  it 'is valid with comment' do
    expect(described_class.new(project: project, comment: 'test')).to be_valid
  end

  it 'is invalid without comment' do
    expect(described_class.new(project: project, comment: '')).to be_invalid
  end

  it 'is valid with old_status and new_status' do
    expect(described_class.new(project: project, old_status: 'new', new_status: 'in progress')).to be_valid
  end

  it 'is invalid without old_status' do
    expect(described_class.new(project: project, old_status: '', new_status: 'in progress')).to be_invalid
  end

  it 'is invalid without new_status' do
    expect(described_class.new(project: project, old_status: 'new', new_status: '')).to be_invalid
  end

  it 'is invalid with wrong old_status' do
    expect(described_class.new(project: project, old_status: 'err', new_status: 'in progress')).to be_invalid
  end

  it 'is invalid with wrong new_status' do
    expect(described_class.new(project: project, old_status: 'new', new_status: 'err')).to be_invalid
  end
end
