require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  before do
    @user = create(:user)
    allow(controller)
    .to receive(:current_user)
    .and_return(@user)
  end
  
  describe 'index' do
    it "正常なレスポンスを返す" do
      get :index
      expect(response).to be_success
    end

    it 'レスポンスコード200を返す' do
      get :index
      expect(response).to have_http_status '200'
    end
  end

  describe 'show' do
    context 'ログイン済み' do
      it "正常なレスポンスを返す" do
        sign_in @user
        get :show,params: {id: 1}
        expect(response).to be_success
      end

      it 'レスポンコード200を返す' do
        sign_in @user
        get :show,params: {id: 1}
        expect(response).to have_http_status '200'
      end
    end
  end

  describe 'edit' do
    context 'ログイン済み' do
      it "正常なレスポンスを返す" do
        sign_in @user
        get :edit,params: {id: @user.id}
        expect(response).to be_success
      end

      it 'レスポンスコード200を返す' do
        sign_in @user
        get :edit,params: {id: @user.id}
        expect(response).to have_http_status '200'
      end
    end
  end

  describe 'update' do
    context 'ログイン済み' do
      it '更新できること' do
        sign_in @user
        user_params = {text: '更新'}
        patch :update,params: {id: @user.id,user: user_params}
      end
    end
  end
end
