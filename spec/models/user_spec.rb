require 'rails_helper'

RSpec.describe User, type: :model do

  # describe 'バリデーションテスト' do
  #   let(:user){build(:user)}
  #   subject {user.valid?}
    
  #   it "名前、メール、パスワードがあれば登録できる" do
  #     expect(user).to be_valid
  #   end
    
  #   context 'nicknameカラム' do
  #     it '未入力でないこと' do
  #       user.nickname = ''
  #       is_expected.to eq false
  #     end

  #     it '名前が未入力であればエラー' do
  #       user.nickname = nil
  #       user.valid?
  #       expect(user.errors[:nickname]).to include("を入力してください")
  #     end

  #     it '名前が11文字以上なら登録できない' do
  #       user.nickname = "a" * 11
  #       user.valid?
  #       expect(user.errors).to be_added(:nickname, :too_long, count: 10)
  #     end
  
  #     it '名前が10文字以下なら登録できる' do
  #       user.nickname = "a" * 10
  #       expect(user).to be_valid
  #     end
  #   end
    
  #   context 'emailカラム' do
      
  #     it '未入力でないこと' do
  #       user.email = ''
  #       is_expected.to eq false
  #     end

  #     it 'メールアドレスが未入力であればエラー' do
  #       user.email = nil
  #       user.valid?
  #       expect(user.errors[:email]).to include("を入力してください")
  #     end

  #     it 'メールアドレスが重複していると登録できない' do
  #       user = create(:user)
  #       user2 = build(:user,email: user.email)
  #       user2.valid?
  #       expect(user2.errors[:email]).to include('はすでに存在します')
  #     end

  #     it '半角英数字以外はエラー' do
  #       user.email = 'メール'
  #       user.valid?
  #       expect(user.errors[:email]).to include('は不正な値です')
  #     end
  #   end
   
  #   context 'passwordカラム' do

  #     it '未入力でないこと' do
  #       user.password = ''
  #       is_expected.to eq false
  #     end

  #     it 'パスワードが未入力であればエラー' do
  #       user.password = nil
  #       user.valid?
  #       expect(user.errors[:password]).to include("を入力してください")
  #     end

  #     it 'パスワードが5文字以下なら登録できない' do
  #       user.password = 'ttt20'
  #       user.valid?
  #       expect(user.errors).to be_added(:password,:too_short,count: 6)
  #     end

  #     it 'パスワードが6文字以上なら登録できる' do
  #       user.password = 'test2020'
  #       expect(user).to be_valid
  #     end

  #     it 'パスワードの再確認が不一致' do
  #       user.password_confirmation = 'test1010'
  #       user.valid?
  #       expect(user.errors[:password_confirmation]).to be_present
  #     end
  #   end
  # end

  describe 'アソシエーションテスト' do
    context 'Tweetモデルとの関係' do   
      it '1:Nとなっている' do
        t = User.reflect_on_association(:tweets)
        expect(t.macro).to eq(:has_many)
      end
    end

    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        t = User.reflect_on_association(:comments)
        expect(t.macro).to eq(:has_many)
      end
    end

    context 'CommentAnalysesモデルとの関係' do
      it '1:Nとなっている' do
        t = User.reflect_on_association(:comment_analyses)
        expect(t.macro).to eq(:has_many)
      end
    end

    context 'CommentForecastモデルとの関係' do
      it '1:Nとなっている' do
        t = User.reflect_on_association(:comment_forecasts)
        expect(t.macro).to eq(:has_many)
      end
    end

    context 'Analysisモデルとの関係' do
      it '1:Nとなっている' do
        t = User.reflect_on_association(:analyses)
        expect(t.macro).to eq(:has_many)
      end
    end

    context 'Forecastモデルとの関係' do
      it '1:Nとなっている' do
        t = User.reflect_on_association(:forecasts)
        expect(t.macro).to eq(:has_many)
      end
    end

    context 'Likeモデルとの関係' do
      it '1:Nとなっている' do
        t = User.reflect_on_association(:likes)
        expect(t.macro).to eq(:has_many)
      end
    end

    context 'Messageモデルとの関係' do
      it '1:Nとなっている' do
        t = User.reflect_on_association(:messages)
        expect(t.macro).to eq(:has_many)
      end
    end

    context 'Entryモデルとの関係' do
      it '1:Nとなっている' do
        t = User.reflect_on_association(:entries)
        expect(t.macro).to eq(:has_many)
      end
    end

    context 'フォローしているユーザーとの関係' do
      it '1:Nとなっている' do
        t = User.reflect_on_association(:followings)
        expect(t.macro).to eq(:has_many)
      end
    end

    context 'フォローされているとの関係' do
      it '1:Nとなっている' do
        t = User.reflect_on_association(:followers)
        expect(t.macro).to eq(:has_many)
      end
    end

    context 'Notificationモデル(active_notifications)との関係' do
      it '1:Nとなっている' do
        t = User.reflect_on_association(:active_notifications)
        expect(t.macro).to eq(:has_many)
      end
    end

    context 'Notificationモデル(passive_notifications)との関係' do
      it '1:Nとなっている' do
        t = User.reflect_on_association(:passive_notifications)
        expect(t.macro).to eq(:has_many)
      end
    end
  end
end
