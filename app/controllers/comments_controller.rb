class CommentsController < ApplicationController
  before_filter :require_user, :except => [:show, :index]
  def create
    clazz = Kernel.const_get(params[:comment][:commentable_type])
    commentable = clazz.find(params[:comment][:commentable_id])
    comment = Comment.build_from(commentable, current_user.id, params[:comment][:body])
    if comment.save
      flash[:notice] = "Thanks for your comment"
      redirect_back_or_default url_for(commentable)
    else
      flash[:error] = "Comment couldn't be saved"
      redirect_back_or_default url_for(commentable)
    end
  end
end
