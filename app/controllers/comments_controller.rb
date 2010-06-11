class CommentsController < InheritedResources::Base
  
  def create
    create! { polymorphic_url @comment.commentable}
  end
  
  def update
    update! { polymorphic_url @comment.commentable }
  end
  
end