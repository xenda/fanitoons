class Member::MessagesController < Member::BaseController

  if Rails::VERSION::STRING >= '2.2'
    extend ActionView::Helpers::SanitizeHelper::ClassMethods
    include ActionView::Helpers::SanitizeHelper
  else
    include ActionView::Helpers::SanitizeHelper
  end

  def show
    @message = current_account.get_message(params[:id])
    @message.read!
    respond_to do |format|
      format.html
      format.xml { render :xml => @message }
    end
  end

  def index
    @folder = (current_account.folders.find(params[:id]) unless params[:id].nil?) || current_account.inbox
    @messages = @folder.messages.paginate :page => params[:page]

    respond_to do |format|
      format.html
      format.rss { render :rss => @messages }
    end
  end

  def new
    @from = current_account
    @to = Account.find(params[:account_id]) if params[:account_id]
    respond_to do |format|
      format.html
      format.xml { render :xml => @message }
    end
  end

  def create
    begin
      to_user = Account.find(params[:message][:to_account_id])
    rescue ActiveRecord::RecordNotFound => e
      error = I18n.t("tog_mail.member.user_not_found")
    end

    @message = Message.new(
      :from => current_account,
      :to => to_user,
      :subject => sanitize(params[:message][:subject]),
      :content => sanitize(params[:message][:content])
    )
    respond_to do |format|
      if !to_user.blank? && @message.dispatch!
        flash[:ok] = I18n.t("tog_mail.member.message_sent")
        format.html { redirect_to(member_messages_path) }
        format.xml { render :xml => @message, :status => :created, :location => member_message_path(:id => @message) }
      else
        flash[:error] = error
        @from = current_account
        format.html { render :action => "new" }
        format.xml { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    message = Message.find(params[:id])
    folder_id = message.folder_id
    message.destroy
    redirect_to :action => 'index', :id => folder_id
  end

  def search
    @match ="%"+sanitize(params[:keyword])+"%"
    @msgs = Message.find_by_sql(["SELECT messages.id
      FROM messages  INNER JOIN
      messages ON messages.message_id = messages.id  INNER JOIN
      folders ON messages.folder_id = folders.id  INNER JOIN
      users ON folders.account_id = accounts.id
    WHERE  (account_id = ?) AND ((subject LIKE ?) OR (content LIKE ?))",current_account.id, @match,@match])
    @fol_msgs = Message.find(:all, :conditions => ['id in (?)',@msgs])
    render :update do |page|
      page.replace_html 'search', :partial => 'search', :object => @fol_msgs
    end
  end

  def reply
    @reply_to = current_account.received_messages.find params[:id]
    respond_to do |format|
      format.html
      format.xml { render :xml => @message }
    end
  end

end