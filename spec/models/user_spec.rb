require 'rails_helper'
RSpec.describe User do
  describe '#create' do
    it "is invalid without a nickname" do
      user = User.new(nickname: "", email: "user1@gmail.com", password: "0000000", password_confirmation: "0000000")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end
    it "is invalid without a email" do
      user = User.new(nickname: "aaa", email: "us", password: "0000000", password_confirmation: "0000000")
      user.valid?
      expect(user.errors[:email]).to include("is invalid")
    end
  end
end

# RSpec.describe User, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
