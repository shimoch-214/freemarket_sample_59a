require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:item) { create(:item) }
  let(:another_item) { create(:item) }
  let(:user) { create(:user) }
  let(:images) { create_list(:image, 3) }
  let(:valid_params) {{
    item: {
      name: 'hoge',
      description: 'hogehoge',
      category_id: 3,
      sizing_id: 3,
      condition: 'normal',
      price: 3000,
      transact_attributes: {
        bearing: 'seller_side',
        delivery_method: 'pending',
        prefecture_id: 4,
        ship_days: 'short'
      }
    },
    image_ids: images.map{ |img| img.id }.join(',')
  }}
  let(:invalid_params) {{
    item: {
      name: '',
      description: '',
      category_id: 3,
      sizing_id: 3,
      condition: 'normal',
      price: 3000,
      transact_attributes: {
        bearing: 'seller_side',
        delivery_method: 'pending',
        prefecture_id: 4,
        ship_days: 'short'
      }
    },
    image_ids: ''
  }}

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
    let!(:items){create_list(
      :item, 
      24,
      name: "keyword",
      description: "keyword"
    )}

    subject { assigns(:items) } 

    it "params[:keyword]のあいまい検索で一致したレコード取得し、新着順で@itemsに紐付いている" do
      keyword = "keyword"
      get :search, params: {keyword: keyword}
      is_expected.to match(items.sort{|a, b| b.created_at <=> a.created_at })
    end

    it "params[:keyword]のあいまい検索で一致しなかった場合、新着商品のレコード取得し、@itemsに紐付いている" do
      keyword = "keyword_mismatch"
      get :search, params: {keyword: keyword}
      is_expected.to match(items.sort{|a, b| b.created_at <=> a.created_at })
    end

    it "params[:keyword]が空だった場合、新着商品のレコード取得し、@itemsに紐付いている" do
      keyword = ""
      get :search, params: {keyword: keyword}
      is_expected.to match(items.sort{|a, b| b.created_at <=> a.created_at })
    end

    it "searchテンプレートを表示する" do
      get :search
      expect(response).to render_template :search
    end
  end

  describe 'DELETE #destroy' do
    context 'when the user is signed in and is the seller' do
      before do
        sign_in item.seller
      end
      context 'as if the status of the item is exhibit' do
        subject { delete :destroy, params: { id: item.id }}
        it 'destroys the item' do
          expect{subject}.to change(Item, :count).by(-1)
        end
        it 'redirects to the mypage_path' do
          is_expected.to redirect_to(mypage_path)
        end
      end
      context 'as if the status of the item is not exhibit' do
        subject { 
          item.transact.update(status: 3)
          delete :destroy, params: { id: item.id }
        }
        it 'does not destroy the item' do
          expect{subject}.to change(Item, :count).by(0)
        end
        it 'redirects to the mypage_path' do
          is_expected.to redirect_to(root_path)
        end
      end
    end
    context 'when the user is signed in but is not the seller' do
      before do
        sign_in item.seller
      end
      subject {
        delete :destroy, params: { id: another_item.id }
      }
      it 'does not destroy the item' do
        # another_itemを生成するため1つ増える
        expect{subject}.to change(Item, :count).by(1)
      end
      it 'redirect to the root_path' do
        is_expected.to redirect_to(root_path)
      end
    end
    context 'when the user is not signed in' do
      subject {
        delete :destroy, params: { id: item.id }
      }
      it 'does not destroy the item' do
        # itemを生成するため一つ増える
        expect{subject}.to change(Item, :count).by(1)
      end
      it 'redirect to the user_session_new_path' do
        is_expected.to redirect_to(user_sessions_new_path)
      end
    end
  end

  describe 'GET #new' do
    context 'when the user is signed in' do
      before do
        sign_in user
        get :new
      end
      it 'renders the :new template' do
        expect(response).to render_template :new
      end
      it 'assigns empty item to @item' do
        expect(assigns(:item)).to be_a_new Item
      end
      it 'assigns empty transact to @item.transact' do
        expect(assigns(:item).transact).to be_a_new Transact
      end
    end

    context 'when the user is not signed in' do
      before do
        get :new
      end
      it 'redirects to the login page if user not signed in' do
        expect(response).to redirect_to(user_sessions_new_path)
      end
    end
  end

  describe 'POST #create' do
    context 'when the user is signed in' do
      before do
        sign_in user
      end

      it 'creates a item with valid params' do
        expect {
          post :create, params: valid_params
        }.to change(Item, :count).by(1)
      end
      it 'does not create a item with invalid_params' do
        expect {
          post :create, params: invalid_params
        }.to change(Item, :count).by(0)
      end
      it 'redirects to the item_path(@item) if successed' do
        post :create, params: valid_params
        expect(response).to redirect_to(item_path(assigns(:item)))
      end
      it 'assigns the user as seller' do
        post :create, params: valid_params
        expect(assigns(:item).seller).to eq user
      end
    end

    context 'when the user is not signed in' do
      before do
        get :create
      end

      it 'redirects to the login page if user not signed in' do
        expect(response).to redirect_to(user_sessions_new_path)
      end
    end

  end

  describe 'GET #edit' do
    before do
      sign_in item.seller
    end

    context 'when the user is signed in and is the seller' do
      subject { 
        get :edit, params: { id: item.id }
      }

      it 'renders the :new template' do
        is_expected.to render_template :new
      end
    end

    context 'when the user is signed in but is not the seller' do
      subject{
        get :edit, params: { id: another_item.id }
      }

      it 'redirects to the top page' do
        is_expected.to redirect_to(root_path)
      end
    end

    context 'when the user is not signed in' do
      before do
        sign_out item.seller
        get :edit, params: { id: item.id }
      end

      it 'redirects to the login page if user not signed in' do
        expect(response).to redirect_to(user_sessions_new_path)
      end
    end
  end

  describe 'PATCH #update' do
    before do
      sign_in item.seller
    end

    context 'when the user is signed in and is the seller' do
      context 'with valid params' do
        subject {
          patch :update, params: valid_params.merge!(id: item.id)
        }
        it 'updates the item' do
          subject
          expect(assigns(:item).reload.price).not_to eq item.price
        end
        it 'redirects to the :show' do
          is_expected.to redirect_to(item_path(item))
        end
      end
      context 'with invalid params' do
        subject {
          patch :update, params: invalid_params.merge!(id: item.id)
        }
        it 'does not update item' do
          subject
          expect(assigns(:item).reload.price).to eq item.price
        end
        it 'renders the :new' do
          is_expected.to render_template :new
        end
      end
    end

    context 'when the user is signed in but is not the seller' do
      subject {get :edit, params: { id: another_item.id }}
      it 'redirects to the top page' do
        is_expected.to redirect_to(root_path)
      end
    end

    context 'when the user is not signed in' do
      before do
        sign_out item.seller
        get :edit, params: { id: item.id }
      end

      it 'redirects to the login page if user not signed in' do
        expect(response).to redirect_to(user_sessions_new_path)
      end
    end
  end

end
