class CreateUserGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :user_groups, {:id => false} do |t|
      t.integer :user_id
      t.integer :group_id
      t.string :status, default: "regular"

      t.timestamps
    end
    execute "ALTER TABLE user_groups ADD PRIMARY KEY (user_id, group_id);"
  end
end
