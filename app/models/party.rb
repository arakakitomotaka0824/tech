class Party < ApplicationRecord
    validates :team_name, {presence: true, uniqueness: true}
    validates :host_id, {presence: true}
    
end
