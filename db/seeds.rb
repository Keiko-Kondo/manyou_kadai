User.create!(name: "管理者",
               email: "admin@admin.com",
               password: "111111",
               password_confirmation: "111111",
               admin: true
               )
User.create!(name: "ユーザー",
             email: "user@user.com",
             password: "111111",
             password_confirmation: "111111",
             admin: false
             )
Label.create!(name: "至急")
Label.create!(name: "重要")
Label.create!(name: "保留")
Label.create!(name: "できれば")
Label.create!(name: "要確認")
Label.create!(name: "大至急")
Label.create!(name: "超重要")
Label.create!(name: "必須")
Label.create!(name: "がんばれ")
Label.create!(name: "いいね")
10.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               admin: true,
               )
end

User.all.each do |user|
 Task.create!(
              user_id: user.id,
              task_name: 'test_task1',
               details:'test_details1',
               deadline:'2020-10-02',
               priority: '中',
               status: '着手中',
               )
end
# Task.create!(task_name: 'test_task1',
#              details:'test_details1',
#              deadline:'2020-10-02',
#              priority: '中',
#              status: '着手中',
#              )
# Task.create!(task_name: 'test_task2',
#              details:'test_details2',
#              deadline:'2020-10-02',
#              priority: '中',
#              status: '着手中',
#              )
# Task.create!(task_name: 'test_task3',
#              details:'test_details3',
#              deadline:'2020-10-02',
#              priority: '中',
#              status: '着手中',
#              )
# Task.create!(task_name: 'test_task4',
#              details:'test_details4',
#              deadline:'2020-10-02',
#              priority: '中',
#              status: '着手中',
#              )
# Task.create!(task_name: 'test_task5',
#              details:'test_details5',
#              deadline:'2020-10-02',
#              priority: '中',
#              status: '着手中',
#              )
# Task.create!(task_name: 'test_task6',
#              details:'test_details6',
#              deadline:'2020-10-02',
#              priority: '中',
#              status: '着手中',
#              )
# Task.create!(task_name: 'test_task7',
#              details:'test_details7',
#              deadline:'2020-10-02',
#              priority: '中',
#              status: '着手中',
#              )
# Task.create!(task_name: 'test_task8',
#              details:'test_details8',
#              deadline:'2020-10-02',
#              priority: '中',
#              status: '着手中',
#              )
# Task.create!(task_name: 'test_task9',
#              details:'test_details9',
#              deadline:'2020-10-02',
#              priority: '中',
#              status: '着手中',
#              )
# Task.create!(task_name: 'test_task10',
#              details:'test_details10',
#              deadline:'2020-10-02',
#              priority: '中',
#              status: '着手中',
#              )
