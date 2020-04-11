class CreateUserEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :user_events, {:id => false} do |t|
      t.integer :user_id
      t.integer :event_id
      t.boolean :assistance, default: false
      t.boolean :interested, default: true

      t.timestamps
    end
    execute "ALTER TABLE user_events ADD PRIMARY KEY (user_id, event_id);"
  end
end
