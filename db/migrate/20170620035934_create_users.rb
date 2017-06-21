class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, comment: '用户名'
      t.string :email, comment: '邮箱'
      t.string :password, comment: '密码'

      # t.boolean :admin, comment: '是否管理员身份', default: false

      t.timestamps
    end
  end
end
