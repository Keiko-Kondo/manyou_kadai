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
Label.create!(name: "至急"
              )
Label.create!(name: "重要"
                            )
Label.create!(name: "保留"
                                          )
