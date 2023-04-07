# frozen_string_literal: true

# Project related changes log
# status change, comment
class ProjectChange < ApplicationRecord
  belongs_to :project

  validates :comment, presence: true, unless: -> { new_status.present? }
  validates :old_status, :new_status,
            inclusion: { in: Project::STATUSES },
            unless: -> { comment.present? }
end
