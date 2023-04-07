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
      if status != new_status
        project_changes.create!(
          old_status: status,
          new_status: new_status
        )
      end
      update!(status: new_status)
    end
  end
end
