class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.integer :user_id
      t.integer :guest_id

      t.timestamps
    end
    add_index :groups, :user_id
    add_index :groups, :guest_id
    add_index :groups, [:user_id, :guest_id], unique: true
  end
end
