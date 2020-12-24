require 'rails_helper'

RSpec.describe Like, type: :model do

  describe 'バリデーションのテスト' do
    let(:like){build(:like)}
    subject { like.valid? }

    it 'user_idとtweet_idがあれば保存できる' do
      expect(like).to be_valid
    end

    context 'tweet_idカラム' do

      it '空だと保存できない' do
        like.tweet_id = ''
        is_expected.to eq false
      end
    end

    context 'user_idカラム' do

      it '空だと保存できない' do
        like.user_id = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userテーブルとの関係' do
      it 'belongs_toになっている' do
        t = Like.reflect_on_association(:user)
        expect(t.macro).to eq(:belongs_to)
      end
    end

    context 'Tweetテーブルとの関係' do
      it 'belongs_toになっている' do
        t = Like.reflect_on_association(:tweet)
        expect(t.macro).to eq(:belongs_to)
      end
    end
  end
end