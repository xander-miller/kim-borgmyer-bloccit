class TopicsController < ApplicationController

  def index

    @topics = Topic.paginate( page: params[ :page ], per_page: 10 )
    authorize @topics

  end

  def show

    @topic = Topic.find( params[ :id ] )
    @posts = @topic.posts.paginate( page: params[ :page ], per_page: 10 )
    authorize @topic

  end

  def new

    @topic = Topic.new
    authorize @topic

  end

  def create

    @topic = Topic.new( topic_params )
    authorize @topic

    if @topic.save
      flash[ :notice ] = "Topic was created."
      redirect_to @topic
    else
      flash[ :error ] = "Error creating topic.  Please try again."
      render :new
    end

  end

  def edit

    @topic = Topic.find( params[ :id ] )
    authorize @topic

  end

  def update

    @topic = Topic.find( params[ :id ] )
    authorize @topic

    if @topic.update_attributes( topic_params )
      flash[ :notice ] = "Topic was updated."
      redirect_to @topic
    else
      flash[ :error ] = "Error updating topic.  Please try again."
      render :edit
    end

  end

  def destroy

    @topic = Topic.find( params[ :id ] )
    authorize @topic

    if @topic.destroy
      flash[ :notice ] = "Topic was deleted."
      redirect_to topics_path
    else
      flash[ :error ] = "Error deleting topic.  Please try again."
      render :show
    end

  end

  private

  def topic_params
    params.require( :topic ).permit( :name, :description, :public )
  end
  
end
