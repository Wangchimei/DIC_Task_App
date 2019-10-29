class Label < ApplicationRecord
  validates :name, presence: true
  has_many :label_relations, dependent: :destroy
  has_many :labeled_tasks, through: :label_relations, source: :task
end
