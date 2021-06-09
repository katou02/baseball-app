require 'rails_helper'

RSpec.describe Map, type: :model do
  let(:map){build(:map)}
  describe 'バリデーションテスト' do
    subject{map.valid?}

    it '全て入力していれば保存できる' do
      expect(map).to be_valid
    end

    context 'textカラム' do
      
      it '未入力だと保存できない' do
        map.text = ''
        is_expected.to eq false
      end

      it 'テキストが未入力であればエラー' do
        map.text = ''
        map.valid?
        expect(map.errors[:text]).to include('を入力してください')
      end

      it '2001文字以上だと保存できない' do
        map.text = 'a' * 2001
        map.valid?
        expect(map.errors).to be_added(:text,:too_long,count: 2000)
      end

      it '2000文字以下なら保存できる' do
        map.text = 'a' * 2000
        expect(map).to be_valid
      end
    end

    context 'addressカラム' do
      
      it '未入力だと保存できない' do
        map.address = ''
        is_expected.to eq false
      end

      it '住所が未入力であればエラー' do
        map.address = ''
        map.valid?
        expect(map.errors[:address]).to include('を入力してください')
      end

      it '101文字以上なら保存できない' do
        map.address = 'a' * 101
        map.valid?
        expect(map.errors).to be_added(:address, :too_long, count: 100)
      end

      it '100文字以下なら保存できる' do
        map.address = 'a' * 100
        expect(map).to be_valid
      end

      context 'schoolカラム' do

        it '未入力だと保存できない' do
          map.school_id = ''
          is_expected.to eq false
        end
  
        it '高校が未入力だとエラー' do
          map.school_id = ''
          map.valid?
          expect(map.errors[:school]).to include('を入力してください')
        end
  
        it '存在しない外部キーなら保存できない' do
          map.school_id = 6
          is_expected.to eq false
        end
  
        it '外部キーが存在するなら保存できる' do
          map.school_id = 1
          expect(map).to be_valid
        end
      end

      context 'tournamentカラム' do
      
        it '未入力なら保存できない' do
          map.tournament_id = ''
          is_expected.to eq false
        end
  
        it '大会が未入力ならエラー' do
          map.tournament_id = ''
          map.valid?
          expect(map.errors[:tournament]).to include('を入力してください')
        end
  
        it '存在しない外部キーなら保存できない' do
          map.tournament_id = 2
          is_expected.to eq false
        end
  
        it '外部キーが存在するなら保存できる' do
          map.tournament_id = 3
          expect(map).to be_valid
        end
      end

      context 'userカラム' do
        it '空なら保存できない' do
          map.user_id = ''
          is_expected.to eq false
        end
  
        it 'ユーザーが空ならエラー' do
          map.user_id = ''
          map.valid?
          expect(map.errors[:user]).to include('を入力してください')
        end

        it '存在しない外部キーなら保存できない' do
          map.user_id = 2
          is_expected.to eq false
        end
  
        it '外部キーが存在するなら保存できる' do
          map.user_id = 1
          expect(map).to be_valid
        end
      end
    end
  end

  describe 'アソシエーションテスト' do
    
    context 'Categoryテーブルとの関係' do
      it '1:Nとなっている' do
        t = Map.reflect_on_association(:categories)
        expect(t.macro).to eq(:has_many)
      end
    end

    context 'Userモデルとの関係' do
      it 'belongs_toになっている' do
        t = Map.reflect_on_association(:user)
        expect(t.macro).to eq(:belongs_to)
      end
    end
  end
end
