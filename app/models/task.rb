class Task < ApplicationRecord
  validates :title, :content, :deadline, presence: true

  enum status: { not_started: 0, in_progress: 1, finished: 2}
end
