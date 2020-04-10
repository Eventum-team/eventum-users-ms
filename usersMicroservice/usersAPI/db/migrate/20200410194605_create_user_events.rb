class CreateUserEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :user_events do |t|
      t.int :user_id
      t.int :event_id
      t.boolean :assistance, default: false
      t.boolean :interested, default: true

      t.timestamps
    end
  end
end
