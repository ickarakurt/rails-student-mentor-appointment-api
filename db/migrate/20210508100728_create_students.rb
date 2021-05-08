class CreateStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :students do |t|

      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.string :time_zone, default: 'UTC'
      t.timestamps

    end
  end
end
