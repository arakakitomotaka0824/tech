class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}


  def index
    @posts= Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @likes_count = Like.where(post_id: @post.id).count
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(title: params[:title],
                     content: params[:content],
                     user_id: @current_user.id)
     if @post.save
          flash[:notice] = "post success title:#{@post.title}"
          redirect_to("/posts/index")
     else
          render 'new'
     end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.title = params[:title]
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "Post edit success title:#{@post.title}"
       redirect_to("/posts/index")
    else
      render("/posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to("/posts/index")
  end

  def team_posts
    @user = Member.find(params[:id])
    @team_name = params[:name]
    @name = Team.where(team_name: params[:name]).where(user_id: @user.id)
    @name = @name.pluck(:guest_id).uniq
    @party = Party.find_by(team_name: params[:name])
    @users = []
    @posts_all = []
    @name.each do |name| 
      @posts_all << Post.where(user_id: name.to_i)
      @users << Member.find_by(id: name.to_i)
    end
    
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

end
