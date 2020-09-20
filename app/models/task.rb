class Task < ApplicationRecord
  validates :task, presence: true, uniqueness: true
end
