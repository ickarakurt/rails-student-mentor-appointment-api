class CreateMentors < ActiveRecord::Migration[6.1]
  def change
    create_table :mentors do |t|

      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :time_zone, default: 'UTC'
      t.timestamps

    end
  end
end
