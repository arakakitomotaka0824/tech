class PostsController < ApplicationController
  def index
    @posts= Post.all.order(created_at: :desc)
  end

  def new
  end

  def create
    @post = Post.new(title: params[:title],content: params[:content])
     if @post.save
          flash[:notice] = "post crear"
          redirect_to("/posts/index")
     else
          render 'new'
     end
  end

  def show
    @post = Post.find_by(id: params[:id])

  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    @post.save
    redirect_to("/posts/index")
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to("/posts/index")
  end

end
