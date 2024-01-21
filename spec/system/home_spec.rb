require 'rails_helper'

RSpec.describe 'Home', type: :system do
  before do
    driven_by :selenium_chrome_headless
  end

  describe 'トップページの検証' do # 説明
    it 'Home#top という文字列が表示される' do # 期待する結果
      visit '/' # ページ遷移
      expect(page).to have_content('Home#top') # 期待する確認結果
    end
  end
end
