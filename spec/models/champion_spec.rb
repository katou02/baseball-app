require 'rails_helper'

RSpec.describe Champion, type: :model do
  let(:champion){build(:champion)}

  describe 'バリデーションのテスト' do
    subject { champion.valid? }

    it '全て入力していれば保存できる' do
      expect(champion).to be_valid
    end

    context 'championカラム' do
      
      it '未入力だと保存できない' do
        champion.champion_school_id = ''
        is_expected.to eq false
      end

      it '優勝予想が未入力だとエラー' do
        champion.champion_school_id = ''
        champion.valid?
        expect(champion.errors[:champion_school]).to include('を入力してください')
      end
    end

    context 'tournamentカラム' do
      
      it '未入力なら保存できない' do
        champion.tournament_id = ''
        is_expected.to eq false
      end

      it '大会が未入力ならエラー' do
        champion.tournament_id = ''
        champion.valid?
        expect(champion.errors[:tournament]).to include('を入力してください')
      end

      it '存在しない外部キーなら保存できない' do
        champion.tournament_id = 2
        is_expected.to eq false
      end

      it '外部キーが存在するなら保存できる' do
        champion.tournament_id = 3
        expect(champion).to be_valid
      end
    end

    context 'userカラム' do
      it '空なら保存できない' do
        champion.user_id = ''
        is_expected.to eq false
      end

      it 'ユーザーが空ならエラー' do
        champion.user_id = ''
        champion.valid?
        expect(champion.errors[:user]).to include('を入力してください')
      end
    end
  end

  describe 'アソシエーションテスト' do
    
    context 'USerテーブルとの関係' do
      it 'belongs_toになっている' do
        t = Champion.reflect_on_association(:user)
        expect(t.macro).to eq(:belongs_to)
      end
    end
  end
end