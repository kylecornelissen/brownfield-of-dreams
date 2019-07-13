# frozen_string_literal: true

class UserNotifierMailer < ApplicationMailer
  def activate(user)
    @user = user
    mail(to: user.email, subject: 'Please Activate Your Account.')
  end

  def invite(user, invite_email, invite_handle)
    @user = user
    @invite_email = invite_email
    @invite_handle = invite_handle
    mail(to: invite_email, subject: "#{@invite_handle}, You've been invited!")
  end
end
