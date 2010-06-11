class CommentsController < InheritedResources::Base
  
  def create
    create! { polymorphic_url [@comment.commentable,@comment]}
  end
  
  def update
    update! { polymorphic_url [@comment.commentable,@comment]}
  end
  
end