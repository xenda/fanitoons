class Member::BaseController < ApplicationController

  before_filter :authenticate_account!

  rescue_from ActiveRecord::RecordNotFound, :with => :bad_record

  private

  def bad_record
     redirect_to root_path
  end

end