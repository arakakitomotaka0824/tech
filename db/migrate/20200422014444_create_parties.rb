class CreateParties < ActiveRecord::Migration[5.2]
  def change
    create_table :parties do |t|
      t.string :team_name
      t.string :image_name

      t.timestamps
    end
  end
end
