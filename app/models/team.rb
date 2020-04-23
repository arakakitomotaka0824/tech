class Team < ApplicationRecord
    validates :team_name, {presence: true}
    validates :user_id, {presence: true}
    validates :guest_id, {presence: true}
    
end
