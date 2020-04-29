class Member < ApplicationRecord
  

  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy

   has_many :passive_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy  

   has_many :active_guest, class_name:  "Team",
                           foreign_key: "user_id",
                           dependent:   :destroy

  
                          
   has_many :guest, through: :active_guest
   has_many :host, through: :passive_guest     
                                    


    
    has_many :following, through: :active_relationships, source: :followed
    has_many :followers, through: :passive_relationships, source: :follower

    validates :name, {presence: true}
    validates :email, {presence: true, uniqueness: true}
    
    has_secure_password
    validates :password, {presence: true}

    def posts
        return Post.where(user_id: self.id)
      end

      def self.search(search) #self.でクラスメソッドとしている
        if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
          Member.where(['name LIKE ?', "%#{search}%"])
        else
          Member.all #全て表示。
        end
      end
      

    

      def follow(other_user)
        following << other_user
      end
    
      # ユーザーをフォロー解除する
      def unfollow(other_user)
        active_relationships.find_by(followed_id: other_user.id).destroy
      end
    
      # 現在のユーザーがフォローしてたらtrueを返す
      def following?(other_user)
        following.include?(other_user)
      end

end
