# frozen_string_literal: true

class InviteController < ApplicationController
  def new; end

  def create
    invite_email = GithubService.new(current_user).get_email(params[:handle])
    invite_handle = params[:handle]
    if invite_email
      UserNotifierMailer.invite(current_user, invite_email, invite_handle).deliver_now
      flash[:success] = 'Successfully sent invite!'
    else
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    end
    redirect_to dashboard_path
  end
end
