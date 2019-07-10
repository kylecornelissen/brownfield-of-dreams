# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:password) }
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name: 'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name: 'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'instance methods' do
    it '#potential_friend' do
      host = create(:user)
      u1 = create(:user, uid: '12345')
      u2 = create(:user, uid: '24680')

      Friendship.create!(user_id: host.id, friend_id: u2.id)

      expect(host.potential_friend('12345')).to eq(true)
      expect(host.potential_friend('24680')).to eq(false)
      expect(host.potential_friend('00000')).to eq(false)
    end
  end
end
