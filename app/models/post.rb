class Post < ApplicationRecord

    validates :title, {presence: true, length:{maximum: 40}}
    validates :content, {presence: true}

    def user
        return Member.find_by(id: self.user_id)
      end


   def self.search(search) #self.でクラスメソッドとしている
     if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
       Post.where(['title LIKE ?', "%#{search}%"]).order(created_at: :desc)
    else 
       Post.all.order(created_at: :desc)
     end
   end
      
      
      

end
