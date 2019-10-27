class Task < ApplicationRecord
  paginates_per 10
  belongs_to :user

  validates :title, :content, :deadline, presence: true
  enum status: { not_started: 0, in_progress: 1, finished: 2}
  enum priority: { low: 0, medium: 1, high: 2}

  scope :title_search, ->(title) { where("title LIKE ?", "%#{title}%") }
  scope :status_search, ->(state) { where(status: Task.statuses[state]) }

  # def self.search(search)
  #   if search
  #     where(['title LIKE ?', "%#{search}%"])
  #   else
  #     all
  #   end
  # end
end
