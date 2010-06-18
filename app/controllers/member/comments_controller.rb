class Member::CommentsController < InheritedResources::Base
  
  def create
    create! { member_message_path (:id => @comment.commentable.id)}
  end
  
  def update
    update! { member_message_path (:id => @comment.commentable.id) }
  end
  
end