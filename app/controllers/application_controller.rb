class ApplicationController < ActionController::Base
before_action :set_current_user


  
    def set_current_user
      @user = Member.find_by(id: params[:id])
      @current_user = Member.find_by(id: session[:user_id])
    end
    
    def authenticate_user
      if @current_user == nil
        flash[:notice] = "ログインが必要です"
        redirect_to("/users/login")
      end
    end
    
    def forbid_login_user
      if @current_user
        flash[:notice] = "すでにログインしています"
        redirect_to("/posts/index")
      end
    end
  


end
