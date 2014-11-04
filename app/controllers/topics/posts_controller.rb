class Topics::PostsController < ApplicationController

  def create

    @topic = Topic.find( params[ :topic_id ] )
    @post = current_user.posts.build( post_params )
    @post.topic = @topic
    authorize @post

    if @post.save
      @post.create_vote
      flash[ :notice ] = "Post was created."
      redirect_to [ @topic, @post ]
    else
      flash[ :error ] = "Error creating post.  Please try again."
      render :new
    end

  end

  def destroy

    @topic = Topic.find( params[ :topic_id ] )
    @post = Post.find( params[ :id ] )
    authorize @post

    if @post.destroy
      flash[ :notice ] = "Post was deleted."
      redirect_to @topic
    else
      flash[ :error ] = "Error deleting post.  Please try again."
      render :show
    end

  end

  def edit

    @topic = Topic.find( params[ :topic_id ] )
    @post = Post.find( params[ :id ] )
    authorize @post

  end

  def new

    @topic = Topic.find( params[ :topic_id ] )
    @post = Post.new
    authorize @post

  end

  def show

    @topic = Topic.find( params[ :topic_id ] )
    @post = Post.find( params[ :id ] ) 
    @comments = @post.comments.paginate( page: params[ :page ], per_page: 10 )
    authorize @topic

  end

  def update

    @topic = Topic.find( params[ :topic_id ] )
    @post = Post.find( params[ :id ] )
    authorize @post

    if @post.update_attributes( post_params )
      flash[ :notice ] = "Post was updated."
      redirect_to [ @topic, @post ]
    else
      flash[ :error ] = "Error updating post.  Please try again."
      render :edit
    end
    
  end

  private

  def post_params
    params.require( :post ).permit( :title, :body, :image )
  end

end
