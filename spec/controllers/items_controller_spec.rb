require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  # let(:item) { create(:item) }

  # describe 'GET #index' do
  #   # it "@itemsに人気カテゴリー・ブランドのitemレコードが紐付いている" do
  #     # ブランドテーブル実装後に記述
  #   # end

  #   it "indexテンプレートを表示する" do
  #     get :index
  #     expect(response).to render_template :index
  #   end
  # end

  # describe 'GET #show' do
  #   before do
  #     get :index
  #   end
  #   it "@itemにparams[:id]のitemレコードが紐付いている" do
  #     expect(assigns(:item)).to eq item
  #   end

    # it "@user_itemsにparams[:id]を出品したユーザーの他のitemレコードが紐付いている" do
      # ブランドテーブル実装後に記述
    # end

    # it "@itemにparams[:id]のitemレコードが紐付いている" do
      # ブランドテーブル実装後に記述
    # end

    # it "showテンプレートを表示する" do
    #   get :index
    #   expect(response).to render_template :index
    # end
  # end

  describe 'GET #index' do
  before do
    items = create_list(:item, 25)
    # items = items.find(1)
    
    # .page(params[:page]).per(132).order("created_at DESC"
  end
    # let(:user) { create(:user) }
    # let(:items) { create_list(:item, 300) }
    it "params[:keyword]のあいまい検索で一致したレコード取得し、@itemsに紐付いている" do
      keyword = "イ"
      search_items = items.where('name LIKE ? OR description LIKE ?', "%#{keyword}%", "%#{keyword}%")
      p search_items
      get :search, params: {keyword: keyword}
      expect(assigns(:keyword)).to eq keyword
      expect(assigns(:items).length).to be >= 1
      expect(assigns(:items)).to match(search_items)
    end

    it "params[:keyword]のあいまい検索で一致しなかった場合、新着商品のレコード取得し、@itemsに紐付いている" do
      keyword = "keyword_mismatch"
      get :search, params: {keyword: keyword}
      # search_items = items.where('name LIKE ? OR description LIKE ?', "%#{keyword}%", "%#{keyword}%")
      expect(assigns(:items).length).to eq 24
      # expect(assigns(:items)).to match(search_items)
    end

    it "params[:keyword]が空だった場合、新着商品のレコード取得し、@itemsに紐付いている" do
      keyword = ""
      get :search, params: {keyword: keyword}
      # search_items = items.where('name LIKE ? OR description LIKE ?', "%#{keyword}%", "%#{keyword}%")
      expect(assigns(:items).length).to eq 24
      # expect(assigns(:items)).to match(search_items)
    end

    it "searchテンプレートを表示する" do
      get :search
      expect(response).to render_template :search
    end
  end
end
  describe 'DELETE #destroy' do
    let!(:item) { FactoryBot.create :item }

    it 'itemテーブルからitemレコードを削除する' do
      expect {
        delete :destroy, params: { id: item.id }
      }.to change(Item, :count).by(-1)
    end

    it '商品削除後にマイページに遷移する' do
      delete :destroy, params: { id: item.id}
      expect( response ).to redirect_to(mypage_path)
    end
  end
end
