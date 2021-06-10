require 'rails_helper'

RSpec.describe Api::V1::TweetsController, type: :controller do
  before do
    @user = create(:user)
    @tweet = create(:tweet,user_id: @user.id)
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
    context 'ログイン済み' do
      it "正常なレスポンスを返す" do
        sign_in @user
        get :show,params: {id: @tweet.id}
        expect(response).to be_success
      end

      it 'レスポンコード200を返す' do
        sign_in @user
        get :show,params: {id: @tweet.id}
        expect(response).to have_http_status '200'
      end
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
        get :new,params: {id: @tweet.id}
        expect(response).to have_http_status '200'
      end
    end
  end

  describe 'edit' do
    context 'ログイン済み' do
      it "正常なレスポンスを返す" do
        sign_in @user
        get :edit,params: {id: @tweet.id}
        expect(response).to be_success
      end

      it 'レスポンスコード200を返す' do
        sign_in @user
        get :edit,params: {id: @tweet.id}
        expect(response).to have_http_status '200'
      end
    end
  end

  describe 'create' do
    context 'ログイン済み' do
      it '保存できること' do
        sign_in @user
        expect {
          post :create,params: @tweet
          expect(response).to
        }
      end
    end
  end

  describe 'update' do
    context 'ログイン済み' do
      it '更新できること' do
        sign_in @user
        tweet_params = {text: '更新'}
        patch :update,params: {id: @tweet.user_id,tweet: tweet_params}
      end
    end
  end

  describe 'destroy' do
    context 'ログイン済み' do
      it '削除できること' do
        sign_in @user
        delete :destroy,params: {id: @tweet.user_id}
      end
    end
  end
end
