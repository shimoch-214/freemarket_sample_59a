require 'rails_helper'

RSpec.describe Api::LikesController, type: :controller do
  let!(:user) { create(:user) }
  let!(:item) { create(:item) }
  let!(:another_item) { create(:item) }
  let!(:like) { create(:like, user_id: user.id, item_id: item.id) }

  describe "#create" do
    before do
      sign_in user
    end

    it "request by ajax" do
      post :create, format: :js, params: { item_id: item.id, user_id:user.id }
      expect(response.content_type).to eq 'text/javascript'
    end
    
    it "accept like" do
      expect { post :create, format: :js, params: { item_id: another_item.id, user_id:user.id} }.to change(Like, :count).by(1)
    end
  end
  describe "#destroy" do
    before do
      sign_in user
    end

    it "request by ajax" do
      delete :destroy, format: :js, params: { item_id: item.id, user_id: user.id, id: like.id }
      expect(response.content_type).to eq 'text/javascript'
    end

    it "accept destroy like" do
      expect { delete :destroy, format: :js, params: {id: like.id,item_id:item.id} }.to change(Like, :count).by(-1)
    end
  end
end