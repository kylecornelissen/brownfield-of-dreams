require "rails_helper"

RSpec.describe UserNotifierMailer, type: :mailer do
  before :each do
    @user = create(:user, username: 'luke_codewalker', first_name: 'Lucas', email: 'lucas@email.com')
    @invite_email = "johnny@email.com"
    @invite_handle = "johnnycoder"
    @mail_activate = described_class.activate(@user).deliver_now
    @mail_invite = described_class.invite(@user, @invite_email, @invite_handle).deliver_now
  end

  it 'activate sends email to user' do
      expect(@mail_activate.subject).to eq('Please Activate Your Account.')
      expect(@mail_activate.to).to eq([@user.email])
      expect(@mail_activate.from).to eq(['no-reply@brownfield-dreams.com'])
      expect(@mail_activate.body.encoded).to match("Hello #{@user.first_name}")
      expect(@mail_activate.body.encoded).to match("to activate your account.")
  end

  it 'invite sends email to github handle' do
      expect(@mail_invite.subject).to eq("#{@invite_handle}, You've been invited!")
      expect(@mail_invite.to).to eq([@invite_email])
      expect(@mail_invite.from).to eq(['no-reply@brownfield-dreams.com'])
      expect(@mail_invite.body.encoded).to match("Hello #{@invite_handle}")
      expect(@mail_invite.body.encoded).to match("#{@user.username} has invited you to join Brownfield of Dreams. You can create an account.")
  end
end
