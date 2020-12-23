require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'バリデーションのテスト' do
    let(:comment){build(:comment)}
    subject { comment.valid? }

    it '全て入力していれば保存できる' do
      expect(comment).to be_valid
    end

    context 'textカラム' do

      it '未入力だと保存できない' do
        comment.text = ''
        is_expected.to eq false
      end

      it 'テキストが未入力であればエラー' do
        comment.text = ''
        comment.valid?
        expect(comment.errors[:text]).to include('を入力してください')
      end

      it '300文字以上だと保存できない' do
        comment.text = 'a' * 301
        comment.valid?
        expect(comment.errors).to be_added(:text, :too_long, count: 300)
      end

      it '300文字以下なら保存できる' do
        comment.text = 'a' * 300
        expect(comment).to be_valid
      end
    end

    context 'userカラム' do
      it '空なら保存できない' do
        comment.user_id = ''
        is_expected.to eq false
      end

      it 'ユーザーが空ならエラー' do
        comment.user_id = ''
        comment.valid?
        expect(comment.errors[:user]).to include('を入力してください')
      end
    end

    context 'tweetカラム' do
      it '空なら保存できない' do
        comment.tweet_id = ''
        is_expected.to eq false
      end

      it 'ユーザーが空ならエラー' do
        comment.tweet_id = ''
        comment.valid?
        expect(comment.errors[:tweet]).to include('を入力してください')
      end
    end
  end

  describe 'アソシエーションのテスト' do
    
    context 'Tweetテーブルとの関係' do
      it '1:Nとなっている' do
        t = Comment.reflect_on_association(:tweet)
        expect(t.macro).to eq(:belongs_to)
      end
    end

    context 'Userテーブルとの関係' do
      it '1:Nとなっている' do
        t = Comment.reflect_on_association(:user)
        expect(t.macro).to eq(:belongs_to)
      end
    end
  end
end