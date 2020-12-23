require 'rails_helper'

RSpec.describe Analysis, type: :model do
  describe 'バリデーションテスト' do
    let(:analysis){build(:analysis)}
    subject {analysis.valid?}

    it '全て入力されていれば保存できる' do
      expect(analysis).to be_valid
    end

    context 'titleカラム' do
      
      it '未入力だと保存できない' do
        analysis.title = ''
        is_expected.to eq false
      end

      it 'タイトルが未入力であればエラー' do
        analysis.title = ''
        analysis.valid?
        expect(analysis.errors[:title]).to include('を入力してください')
      end

      it '31文字以上だと保存できない' do
        analysis.title = 'a' * 31
        analysis.valid?
        expect(analysis.errors).to be_added(:title, :too_long, count: 30)
      end

      it '30文字以下なら保存できる' do
        analysis.title = 'a' * 30
        expect(analysis).to be_valid
      end
    end

    context 'textカラム' do

      it '未入力だと保存できない' do
        analysis.text = ''
        is_expected.to eq false
      end

      it 'テキストが未入力であればエラー' do
        analysis.text = ''
        analysis.valid?
        expect(analysis.errors[:text]).to include('を入力してください')
      end

      it '2001文字以上なら保存できない' do
        analysis.text = 'a' * 2001
        analysis.valid?
        expect(analysis.errors).to be_added(:text, :too_long, count: 2000)
      end

      it '2000文字以下なら保存できる' do
        analysis.text = 'a' * 2000
        expect(analysis).to be_valid
      end
    end

    context 'attackカラム' do
      
      it '未入力だと保存できない' do
        analysis.attack = ''
        is_expected.to eq false
      end

      it 'テキストが未入力であればエラー' do
        analysis.attack = ''
        analysis.valid?
        expect(analysis.errors[:attack]).to include('を入力してください')
      end
    end

    context 'defensiveカラム' do
      
      it '未入力だと保存できない' do
        analysis.defensive = ''
        is_expected.to eq false
      end

      it 'テキストが未入力であればエラー' do
        analysis.defensive = ''
        analysis.valid?
        expect(analysis.errors[:defensive]).to include('を入力してください')
      end
    end

    context 'pitcherカラム' do
      
      it '未入力だと保存できない' do
        analysis.pitcher = ''
        is_expected.to eq false
      end

      it 'テキストが未入力であればエラー' do
        analysis.pitcher = ''
        analysis.valid?
        expect(analysis.errors[:pitcher]).to include('を入力してください')
      end
    end

    context 'expectationsカラム' do
      
      it '未入力だと保存できない' do
        analysis.expectations = ''
        is_expected.to eq false
      end

      it 'テキストが未入力であればエラー' do
        analysis.expectations = ''
        analysis.valid?
        expect(analysis.errors[:expectations]).to include('を入力してください')
      end
    end

    context 'schoolカラム' do

      it '未入力だと保存できない' do
        analysis.school_id = ''
        is_expected.to eq false
      end

      it '学校が未入力だとエラー' do
        analysis.school_id = ''
        analysis.valid?
        expect(analysis.errors[:school]).to include('を入力してください')
      end

      it '存在しない外部キーなら保存できない' do
        analysis.school_id = 4
        is_expected.to eq false
      end

      it '外部キーが存在するなら保存できる' do
        analysis.school_id = 1
        expect(analysis).to be_valid
      end
    end

    context 'tournamentカラム' do
      
      it '未入力なら保存できない' do
        analysis.tournament_id = ''
        is_expected.to eq false
      end

      it '大会が未入力ならエラー' do
        analysis.tournament_id = ''
        analysis.valid?
        expect(analysis.errors[:tournament]).to include('を入力してください')
      end

      it '存在しない外部キーなら保存できない' do
        analysis.tournament_id = 2
        is_expected.to eq false
      end

      it '外部キーが存在するなら保存できる' do
        analysis.tournament_id = 3
        expect(analysis).to be_valid
      end
    end

    context 'userカラム' do
      it '空なら保存できない' do
        analysis.user_id = ''
        is_expected.to eq false
      end

      it 'ユーザーが空ならエラー' do
        analysis.user_id = ''
        analysis.valid?
        expect(analysis.errors[:user]).to include('を入力してください')
      end
    end
  end

  describe 'アソシエーションテスト' do
    
    context 'CommentAnalysisモデルとの関係' do
      it '1:Nにとなっている' do
        t = Analysis.reflect_on_association(:comment_analyses)
        expect(t.macro).to eq(:has_many)
      end
    end

    context 'Categoryモデルとの関係' do
      it '1:Nにとなっている' do
        t = Analysis.reflect_on_association(:categories)
        expect(t.macro).to eq(:has_many)
      end
    end

    context 'Userモデルとの関係' do
      it '1:Nにとなっている' do
        t = Analysis.reflect_on_association(:user)
        expect(t.macro).to eq(:belongs_to)
      end
    end
  end
end