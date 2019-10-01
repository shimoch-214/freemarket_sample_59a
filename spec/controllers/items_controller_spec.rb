require 'rails_helper'

RSpec.describe ItemsController, type: :controller do

  describe 'GET #index' do
    # it "@itemsに人気カテゴリー・ブランドのitemレコードが紐付いている" do
      # ブランドテーブル実装後に記述
    # end

    it "indexテンプレートを表示する" do
      get :index
      expect(response).to render_template :index
    end
  end

end