class Task < ApplicationRecord
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
  belongs_to :user
  validates :task_name, presence: true
  validates :details, presence: true
  scope :search, -> (search_params) do
    return if search_params.blank?
    task_like(search_params[:task_name])
      .status_is(search_params[:status])
      .label_is(search_params[:label_id])
  end
  scope :task_like, -> (task_name) { where('task_name LIKE ?', "%#{task_name}%") if task_name.present? }
  scope :status_is, -> (status) { where(status: status) if status.present?}
  scope :label_is, -> (label_id) { joins(:labels).where(labels: { id: label_id }) if label_id.present?}
end
