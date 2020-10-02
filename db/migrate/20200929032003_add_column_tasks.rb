class AddColumnTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :deadline, :datetime
    add_column :tasks, :status, :string, default: '未登録'
    add_column :tasks, :priority, :string, default: '未登録'
  end
end
