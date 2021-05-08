class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|

      t.datetime 'start_date', null: false
      t.text :call_reason
      t.references :student, null: false, index: true, foreign_key: true
      t.references :mentor, null: false, index: true, foreign_key: true
      t.timestamps

    end
  end
end
