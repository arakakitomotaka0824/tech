class AddImageNameToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :image_name, :string
  end
end
