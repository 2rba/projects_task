# frozen_string_literal: true

# Project details
class Project < ApplicationRecord
  STATUSES = [
    NEW = 'new',
    IN_PROGRESS = 'in progress',
    DONE = 'done'
  ].freeze

  has_many :project_changes, dependent: :destroy

  validates :name, presence: true
  validates :status, inclusion: { in: Project::STATUSES }

  def update_status!(new_status)
    transaction do
      project_changes.create!(old_status: status, new_status: new_status) if status != new_status
      update!(status: new_status)
    end
  end
end
