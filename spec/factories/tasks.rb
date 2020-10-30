FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    task_name { 'test_task1' }
    details { 'test_details1' }
    deadline { '2020-10-02' }
    priority { '中' }
    status { '着手中' }
    association :user
  end
  factory :second_task, class: Task do
    task_name { 'test_task2' }
    details { 'test_details2' }
    deadline { '2020-10-01' }
    priority { '中' }
    status { '完了' }
    association :user
  end
end
