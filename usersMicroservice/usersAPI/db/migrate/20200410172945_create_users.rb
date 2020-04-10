class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone_number
      t.int :age
      t.int :career
      t.string :status
      t.boolean :web_notification_status, default: false
      t.boolean :mobile_notification_status, default: false

      t.timestamps
    end
  end
end
