class CreateUserGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :user_groups do |t|
      t.int :user_id
      t.int :group_id
      t.string :status, default: "regular"

      t.timestamps
    end
    execute "ALTER TABLE user_groups ADD PRIMARY KEY (user_id, group_id);"
  end
end
