class Post < ApplicationRecord

    validates :title, {presence: true, length:{maximum: 40}}
    validates :content, {presence: true}

    def user
        return Member.find_by(id: self.user_id)
      end
      
      

end
