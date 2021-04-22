require 'rails_helper'

RSpec.describe Api::V1::TweetsController, type: :controller do
  describe 'index' do
    context '認証済みユーザーとして' do
      before do
        @user = create(:user)
      end

      it '正常にレスポンスを返す' do
        sign_in @user
        get :index
        expect(response).to be_success
      end

      it '200レスポンスを返すこと' do
        sign_in @user
        get :index
        expect(response).to have_http_status '200'
      end
    end
  end

  describe 'show' do
    context '認証されたユーザーとして' do
      before do
        @user = create(:user)
        @tweet = create(:tweet,user_id: @user.id)
      end

      it '正常にレスポンスを返す' do
        sign_in @user
        get :show,params: {id: @tweet.id}
        expect(response).to be_success
      end
    end
  end
end
