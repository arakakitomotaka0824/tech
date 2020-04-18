class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login,
                                            ]}
  before_action :ensure_correct_user, {only: [:edit, :update]}


  def index
    @users = Member.all
  end

  def show
    @user = Member.find_by(id: params[:id])
    
  end

  def new
    @user = Member.new
    
  end

  def create
    @user = Member.new(
      name: params[:name],
      email:params[:email],
      password: params[:password],
      image_name: "default_user.jpg"
    )
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "success signup"
      redirect_to("/users/#{@user.id}")
    else
      render('users/new')
    end
  end

  def edit
    @user = Member.find_by(id: params[:id])
  end

  def update
    @user = Member.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]

    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
      
    end

    if @user.save
      redirect_to("/users/#{@user.id}")
    else
      render('users/edit')
    end
  end

  def login_form
  end

  def login
    @user = Member.find_by(email: params[:email],password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to("/users/#{@user.id}")
    else
      render('users/login_form')
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to("/users/login")
  end

  def likes
    @user = Member.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
   
  end



  def following
    @title = "Following"
    @user  = Member.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = Member.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end


  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

  



  

  
end
