class CommentsController < ApplicationController

  respond_to :html, :js

  def create

    @post = Post.find( params[ :post_id ] )
    @comments = @post.comments

    @comment = current_user.comments.build( comment_params )
    @comment.post = @post
    @new_comment = Comment.new

    authorize @comment

    if @comment.save
      flash[ :notice ] = "Comment was saved."
    else
      flash[ :error ] = "Error saving comment. Please try again."
    end

    respond_with( @comment ) do | format |
      format.html { redirect_to [ @post.topic, @post ] }
    end

  end

  def destroy

    @post = Post.find( params[ :post_id ] )
    @comment = @post.comments.find( params[ :id ] )
    authorize @comment

    if @comment.destroy
      flash[ :notice ] = "Comment was deleted."
    else
      flash[ :error ] = "Error deleting comment.  Please try again."
    end

    respond_with( @comment ) do | format |
      format.html { redirect_to [ @post.topic, @post ] }
    end

  end

  private

  def comment_params
    params.require( :comment ).permit( :body )
  end

end
