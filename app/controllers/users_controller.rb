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
    @groups = Party.where(host_id: @user.id)
    
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

  def team_member
    @user = Member.find(params[:id])
    @team_name = params[:name]
    @name = Team.where(team_name: @team_name)
    @name = @name.pluck(:guest_id).uniq
    @party = Party.find_by(team_name: params[:name])
    @users = []
    @name.each do |name| 
      @users << Member.find_by(id: name.to_i)
    end
    
  end

  def new_group
    @user = Member.find_by(id: params[:id])
    @group = Party.new
    @team = Team.new
  end

  def create_group
    @user = Member.find_by(params[:id])
    @guests = Member.where.not(name: @user.id)
    @guest = Member.find_by(name: params[:guest])
    
    @group = Party.new(
      team_name: params[:name],
      host_id: @user.id,
      image_name: "default_group.jpg"
    )
    
    @team = Team.new(
      user_id: @user.id,
      guest_id: @guest.id,
      team_name: @group.team_name
    )  
        
    if @group.save
      @team.save
      redirect_to("/users/#{@user.id}/team/#{@group.team_name}/posts")
    else
      render("users/#{@user.id}")
    end
  end

  def edit_group
    @user = Member.find_by(id: params[:id])
    @group = Party.find_by(team_name: params[:name])
    @team = Team.find_by(team_name: params[:name])
  end

  def update_group
    @user = Member.find_by(id: params[:id])
    @guest = Member.find_by(name: params[:guest])
    @group = Party.find_by(team_name: params[:name])
    @team = Team.find_by(team_name: params[:name])

    @ttt = Team.new(
        user_id: @user.id,
        guest_id: @guest.id,
        team_name: @group.team_name
      )
       
    if params[:image]
      @group.image_name = "#{@group.id}.jpg"
      image = params[:image]
      File.binwrite("public/group_images/#{@group.image_name}", image.read) 
      @group.save
    end
  
    if @ttt.save
      redirect_to("/users/#{@user.id}/team/#{@group.team_name}/posts")
    else
      render('users/edit_group')
    end
  end

  def destroy
    @user = Member.find_by(id: params[:id])
    @group = Party.find_by(team_name: params[:name])
    @team = Team.where(team_name: params[:name])
    @group.destroy
    @team.destroy
    redirect_to("/users/#{@user.id}")
  end


  


  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

  



  

  
end
