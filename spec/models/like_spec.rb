require 'rails_helper'

RSpec.describe Like, type: :model do
  describe '#create' do
    it "is valid with a user_id,like_id" do
      user=create(:user)
      item=create(:item)
      like =build(:like,user_id:user.id,item_id:item.id)
      like.valid?
      expect(like).to be_valid
    end

    it "is valid without only user_id" do
      user=create(:user)
      item=create(:item)
      like =build(:like,user_id:nil,item_id: item.id)
      like.valid?
      expect(like.errors[:user_id]).to include("を入力してください")
    end

    it "is valid without only item_id" do
      user=create(:user)
      item=create(:item)
      like =build(:like,user_id:user.id,item_id: nil)
      like.valid?
      expect(like.errors[:item_id]).to include("を入力してください")
    end

    it "is valid without blank" do
      user=create(:user)
      item=create(:item)
      like =build(:like,user_id:nil,item_id: nil)
      like.valid?
      expect(like.errors[:item_id]).to include("を入力してください")
      expect(like.errors[:user_id]).to include("を入力してください")
    end
  end
end