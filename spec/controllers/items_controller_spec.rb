require 'rails_helper'

RSpec.describe ItemsController, type: :controller do

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
    # it "@itemにparams[:id]のitemレコードが紐付いている" do
      # ブランドテーブル実装後に記述
    # end

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

  describe 'DELETE #destroy' do
    it 'itemテーブルからitemレコードを削除する' do
      # binding.pry
      item = build(:item)
      item.save
      delete :destroy, params: {id: item}
      expect{ item.destroy }.to change{Item.count}.by(-1)
    end

    # it '商品削除後にマイページに遷移する'
    # expect( response ).to redirect_to(mypage_path)
    # end
    # it 'itemを削除するとimagesテーブルの紐づくレコードも削除される' do
    # end
    # it 'itemを削除するとimagesテーブルの紐づくレコードも削除される' do
    # end

  end
end