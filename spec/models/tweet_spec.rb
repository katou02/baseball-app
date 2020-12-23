require 'rails_helper'

RSpec.describe Tweet, type: :model do

  let(:tweet){build(:tweet)}
  describe 'バリデーションのテスト' do
    subject { tweet.valid? }

    it '全て入力していれば保存できる' do
      expect(tweet).to be_valid
    end

    context 'title_infoカラム' do

      it '未入力だと保存できない' do
        tweet.title_info = ''
        is_expected.to eq false
      end

      it 'タイトルが未入力であればエラー' do
        tweet.title_info = nil
        tweet.valid?
        expect(tweet.errors[:title_info]).to include('を入力してください')
      end

      it '31文字以上だと保存できない' do
        tweet.title_info = 'a' * 31
        tweet.valid?
        expect(tweet.errors).to be_added(:title_info, :too_long, count: 30)
      end

      it '30文字以下なら保存できる' do
        tweet.title_info = 'a' * 30
        expect(tweet).to be_valid
      end
    end

    context 'textカラム' do

      it '未入力だと保存できない' do
        tweet.text = ''
        is_expected.to eq false
      end

      it 'テキストが未入力であればエラー' do
        tweet.text = ''
        tweet.valid?
        expect(tweet.errors[:text]).to include('を入力してください')
      end

      it '2001文字以上なら保存できない' do
        tweet.text = 'a' * 2001
        tweet.valid?
        expect(tweet.errors).to be_added(:text, :too_long, count: 2000)
      end

      it '2000文字以下なら保存できる' do
        tweet.text = 'a' * 2000
        expect(tweet).to be_valid
      end
    end

    context 'school_aカラム' do
      
      it '未入力だと保存できない' do
        tweet.school_a_id = ''
        is_expected.to eq false
      end

      it '学校Aが未入力だとエラー' do
        tweet.school_a_id = ''
        tweet.valid?
        expect(tweet.errors[:school_a]).to include('を入力してください')
      end

      it '存在しない外部キーなら保存できない' do
        tweet.school_a_id = 6
        is_expected.to eq false
      end

      it '外部キーが存在するなら保存できる' do
        tweet.school_a_id = 1
        expect(tweet).to be_valid
      end
    end

    context 'school_bカラム' do
      
      it '未入力だと保存できない' do
        tweet.school_b_id = ''
        is_expected.to eq false
      end

      it '学校Bが未入力だとエラー' do
        tweet.school_b_id = ''
        tweet.valid?
        expect(tweet.errors[:school_b]).to include('を入力してください')
      end

      it '存在しない外部キーなら保存できない' do
        tweet.school_b_id = 4
        is_expected.to eq false
      end

      it '外部キーが存在するなら保存できる' do
        tweet.school_b_id = 2
        expect(tweet).to be_valid
      end
    end

    context 'school_a_scoreカラム' do

      it '未入力だと保存できない' do
        tweet.school_a_score = ''
        is_expected.to eq false
      end

      it '学校Aのスコアが未入力ならエラー' do
        tweet.school_a_score = ''
        tweet.valid?
        expect(tweet.errors[:school_a_score]).to include('を入力してください')
      end
    end

    context 'school_b_scoreカラム' do
      
      it '未入力だと保存できない' do
        tweet.school_b_score = ''
        is_expected.to eq false
      end

      it '学校Bのスコアが未入力ならエラー' do
        tweet.school_b_score = ''
        tweet.valid?
        expect(tweet.errors[:school_b_score]).to include('を入力してください')
      end
    end

    context 'tournamentカラム' do
      
      it '未入力なら保存できない' do
        tweet.tournament_id = ''
        is_expected.to eq false
      end

      it '大会が未入力ならエラー' do
        tweet.tournament_id = ''
        tweet.valid?
        expect(tweet.errors[:tournament]).to include('を入力してください')
      end

      it '存在しない外部キーなら保存できない' do
        tweet.tournament_id = 2
        is_expected.to eq false
      end

      it '外部キーが存在するなら保存できる' do
        tweet.tournament_id = 3
        expect(tweet).to be_valid
      end
    end

    context 'userカラム' do
      it '空なら保存できない' do
        tweet.user_id = ''
        is_expected.to eq false
      end

      it 'ユーザーが空ならエラー' do
        tweet.user_id = ''
        tweet.valid?
        expect(tweet.errors[:user]).to include('を入力してください')
      end
    end
  end

  describe 'アソシエーションテスト' do
    
    context 'Commentテーブルとの関係' do
      it '1:Nとなっている' do
        t = Tweet.reflect_on_association(:comments)
        expect(t.macro).to eq(:has_many)
      end
    end

    context 'Categoryテーブルとの関係' do
      it '1:Nとなっている' do
        t = Tweet.reflect_on_association(:categories)
        expect(t.macro).to eq(:has_many)
      end
    end

    context 'Likeテーブルとの関係' do
      it '1:Nとなっている' do
        t = Tweet.reflect_on_association(:likes)
        expect(t.macro).to eq(:has_many)
      end
    end

    context 'Notificationテーブルとの関係' do
      it '1:Nとなっている' do
        t = Tweet.reflect_on_association(:notifications)
        expect(t.macro).to eq(:has_many)
      end
    end

    context 'Userモデルとの関係' do
      it '1:Nにとなっている' do
        t = Tweet.reflect_on_association(:user)
        expect(t.macro).to eq(:belongs_to)
      end
    end
  end
end