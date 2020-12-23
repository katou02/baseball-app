require 'rails_helper'

RSpec.describe CommentAnalysis, type: :model do
  describe 'バリデーションのテスト' do
    let(:comment_ays){build(:comment_analysis)}
    subject { comment_ays.valid? }

    it '全て入力していれば保存できる' do
      expect(comment_ays).to be_valid
    end

    context 'textカラム' do

      it '未入力だと保存できない' do
        comment_ays.text = ''
        is_expected.to eq false
      end

      it 'テキストが未入力であればエラー' do
        comment_ays.text = ''
        comment_ays.valid?
        expect(comment_ays.errors[:text]).to include('を入力してください')
      end

      it '300文字以上だと保存できない' do
        comment_ays.text = 'a' * 301
        comment_ays.valid?
        expect(comment_ays.errors).to be_added(:text, :too_long, count: 300)
      end

      it '300文字以下なら保存できる' do
        comment_ays.text = 'a' * 300
        expect(comment_ays).to be_valid
      end
    end

    context 'userカラム' do
      it '空なら保存できない' do
        comment_ays.user_id = ''
        is_expected.to eq false
      end

      it 'ユーザーが空ならエラー' do
        comment_ays.user_id = ''
        comment_ays.valid?
        expect(comment_ays.errors[:user]).to include('を入力してください')
      end
    end

    context 'analysisカラム' do
      it '空なら保存できない' do
        comment_ays.analysis_id = ''
        is_expected.to eq false
      end

      it 'ユーザーが空ならエラー' do
        comment_ays.analysis_id = ''
        comment_ays.valid?
        expect(comment_ays.errors[:analysis]).to include('を入力してください')
      end
    end
  end

  describe 'アソシエーションのテスト' do
    
    context 'Analysisテーブルとの関係' do
      it '1:Nとなっている' do
        t = CommentAnalysis.reflect_on_association(:analysis)
        expect(t.macro).to eq(:belongs_to)
      end
    end

    context 'Userテーブルとの関係' do
      it '1:Nとなっている' do
        t = CommentAnalysis.reflect_on_association(:user)
        expect(t.macro).to eq(:belongs_to)
      end
    end
  end
end