class Task < ApplicationRecord
  validates :task_name, presence: true
  validates :details, presence: true
  scope :search, -> (search_params) do
    return if search_params.blank?

    task_like(search_params[:task_name])
      .status_is(search_params[:status])

  end
  scope :task_like, -> (task_name) { where('task_name LIKE ?', "%#{task_name}%") if task_name.present? }
  scope :status_is, -> (status) { where(status: status) if status.present? }
end
