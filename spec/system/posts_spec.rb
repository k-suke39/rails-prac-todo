require 'rails_helper'

describe 'Post', type: :system do
  before do
    driven_by(:rack_test) # ヘッドレスモードで実行
    @user = create(:user) # ログイン用ユーザー作成
  end

  # 事前準備のデータ
  let(:title) { 'テストタイトル' }
  let(:content) { 'テスト本文' }

  describe '投稿機能の検証' do
    subject do
      fill_in 'post_title', with: title
      fill_in 'post_content', with: content
      click_button 'ログを記録'
    end
    context 'ログインしていない場合' do
      before { visit '/posts/new' }
      it 'ログインページにリダイレクトされる' do
        expect(current_path).to eq('/users/sign_in')
        expect(page).to have_content('ログインしてください。')
      end
    end

    context 'ログインしている場合' do
      before do
        sign_in @user
        visit '/posts/new'
      end
      it 'ログインページへリダイレクトしない' do
        expect(current_path).not_to eq('/users/sign_in')
      end
      context '正常系' do
        context 'パラメータが正常な場合' do
          it 'Postを作成できる' do
            fill_in 'post_title', with: title
            fill_in 'post_content', with: content
            click_button 'ログを記録'
            expect(Post.count).to eq(1)
            expect(current_path).to eq('/')
            expect(page).to have_content('投稿しました')
          end
        end
      end
      context 'パラメータが異常な場合' do
        let(:title) { nil }
        it 'Postを作成できない' do
          expect { subject }.not_to change(Post, :count)
          expect(page).to have_content('投稿に失敗しました')
        end
        it '入力していた内容は維持される' do
          subject
          expect(page).to have_field('post_content', with: content)
        end
      end
    end
  end
end
