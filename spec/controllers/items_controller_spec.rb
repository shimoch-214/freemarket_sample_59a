require 'rails_helper'

RSpec.describe ItemsController, type: :controller do

  describe 'GET #index' do
    # it "@itemsに人気カテゴリー・ブランドのitemレコードが紐付いている" do
    #   items = create_list(:item, 60) 
    #   get :index
    #   expect(assigns(:items)).to match(tweets.sort{ |a, b| b.created_at <=> a.created_at } )
    # end

    it "indexテンプレートを表示する" do
      get :index
      expect(response).to render_template :index
    end
  end

end