class Member::BaseController < ApplicationController

  before_filter :authenticate_account!

  rescue_from ActiveRecord::RecordNotFound, :with => :bad_record

  private

  def bad_record
     render :template => "member/site/not_found"
  end

end