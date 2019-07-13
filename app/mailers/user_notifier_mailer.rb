class UserNotifierMailer < ApplicationMailer
  def activate(user)
    @user = user
    mail(to: user.email, subject: "Please Activate Your Account.")
  end

  def invite(user, invite_email)
    @user = user
    mail(to: invite_email, subject: "You've been invited!")
  end
end
