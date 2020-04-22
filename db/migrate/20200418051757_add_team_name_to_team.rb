class AddTeamNameToTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :team_name, :string
  end
end
