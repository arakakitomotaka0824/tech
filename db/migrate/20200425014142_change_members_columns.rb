class ChangeMembersColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :password_digest, :string
    remove_column :members, :password, :string
  end
end
