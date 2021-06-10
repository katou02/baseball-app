require 'rails_helper'

RSpec.describe Api::V1::MapsController, type: :controller do
  before do
    @user = create(:user)
    @map = create(:map,user_id: @user.id)
  end
      
  describe 'index' do
    context 'ログイン済み' do
      it "正常なレスポンスを返す" do
        sign_in @user
        get :index
        expect(response).to be_success
      end
    
      it 'レスポンスコード200を返す' do
        sign_in @user
        get :index
        expect(response).to have_http_status '200'
      end
    end
  end
    
  describe 'show' do
    it "正常なレスポンスを返す" do
      get :show,params: {id: @map.id}
      expect(response).to be_successful
    end
    
    it 'レスポンコード200を返す' do
      get :show,params: {id: @map.id}
      expect(response).to have_http_status '200'
    end
  end
    
  describe 'new' do
    context 'ログイン済み' do
      it "正常なレスポンスを返す" do
        sign_in @user
        get :new
        expect(response).to be_success
      end
    
      it 'レスポンスコード200を返す' do
        sign_in @user
        get :new,params: {id: @map.id}
        expect(response).to have_http_status '200'
      end
    end
  end
    
  describe 'edit' do
    context 'ログイン済み' do
      it "正常なレスポンスを返す" do
        sign_in @user
        get :edit,params: {id: @map.id}
        expect(response).to be_success
      end
    
      it 'レスポンスコード200を返す' do
        sign_in @user
        get :edit,params: {id: @map.id}
        expect(response).to have_http_status '200'
      end
    end
  end
    
  describe 'create' do
    context 'ログイン済み' do
      it '保存できること' do
        sign_in @user
        expect {
          post :create,params: @map
          expect(response).to
        }
      end
    end
  end
    
  describe 'update' do
    context 'ログイン済み' do
      it '更新できること' do
        sign_in @user
        map_params = {text: '更新'}
        patch :update,params: {id: @map.user_id,tweet: map_params}
      end
    end
  end
    
  describe 'destroy' do
    context 'ログイン済み' do
      it '削除できること' do
        sign_in @user
        delete :destroy,params: {id: @map.user_id}
      end
    end
  end
end
