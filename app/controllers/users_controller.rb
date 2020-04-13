class UsersController < ApplicationController


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
      password: params[:password]
    )
    if @user.save
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
      redirect_to('/posts/index')
    else
      render('users/login_form')
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to("/users/login")
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
  

  
end
