require 'rails_helper'

describe 'Posts' do
  before { @user = create(:user) } # 各テストで使用できるユーザーを作成
  # 対象エンドポイント
  describe 'GET posts/new' do
    context 'ログインしていない場合' do
      it 'HTTPステータス 302を返す' do
        get '/posts/new'
        expect(response).to have_http_status(302)
      end
      it 'ログインページにリダイレクトされる' do
        get '/posts/new'
        expect(response).to redirect_to '/users/sign_in'
      end
    end
    context 'ログインしている場合' do
      before { sign_in @user }
      it 'HTTPステータス 200を返す' do
        get '/posts/new'
        expect(response).to have_http_status(200)
      end

      it 'ログインページにリダイレクトされない' do
        get '/posts/new'
        expect(response).not_to redirect_to '/users/sign_in'
      end
    end
  end
end
