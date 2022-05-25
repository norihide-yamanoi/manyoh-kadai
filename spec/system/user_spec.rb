require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  describe 'ユーザ登録のテスト' do
    context '登録しようとすると' do
      it 'ユーザの新規登録ができる' do
       visit new_user_path
       fill_in "user[name]",with: "dog"
       fill_in "user[email]",with: "wanwan@wan.com"
       fill_in "user[password]",with: "wanwan"
       fill_in "user[password_confirmation]",with: "wanwan"
       click_on "Create my account"
       expect(page).to have_content 'dog'
      end
    end
    context 'ユーザがログインせずタスク一覧画面に飛ぼうとしたとき' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'Log in'
      end
    end
  end

  describe 'セッション機能のテスト' do
    let!(:user) { FactoryBot.create(:admin_user) }
    let!(:ordinary_user) { FactoryBot.create(:ordinary_user) }
    context 'ログインしようとすると' do
      it 'ログインできる' do
        visit new_session_path
        fill_in "session[email]",with: "wanwan@wan.com"
        fill_in "session[password]",with: "wanwan"
        click_on "Log in"
        expect(current_path).to eq user_path(id: user.id)
      end
    end
    context 'ログイン状態で' do
      before do
        visit new_session_path
        fill_in "session[email]",with: "wanwan@wan.com"
        fill_in "session[password]",with: "wanwan"
        click_on "Log in"
      end
      it '自分の詳細画面(マイページ)に飛べる' do
        click_on "Profile"
        expect(current_path).to eq user_path(id: user.id)
      end
      it '他人のページにアクセスするとタスク一覧画面に飛ぶ' do
        visit user_path(id: ordinary_user.id)
        expect(page).to have_content 'タスク一覧'
      end
      it 'ログアウトできる'do
        click_on "Logout"
        expect(page).to have_content "ログアウトしました"
      end
    end
  end

  describe '管理画面のテスト' do
    before do
      FactoryBot.create(:admin_user)
      FactoryBot.create(:ordinary_user)
      visit new_session_path
    end
    context 'タスク一覧画面から' do
      it '管理ユーザは管理画面にアクセスできる' do
        fill_in "session_email", with: "wanwan@wan.com"
        fill_in "session_password", with: "wanwan"
        click_on "Log in"
        click_on "管理者画面へ"
        expect(page).to have_content "ユーザー一覧"
      end
      it '一般ユーザは管理画面にアクセスできない'do
        fill_in "session_email", with: "nyannyan@nyan.com"
        fill_in "session_password", with: "nyannyan"
        click_on "Log in"
        visit admin_users_path
        expect(page).to have_content "管理者以外立ち入り禁止‼︎"
      end
    end
    context 'ユーザー一覧画面から' do
      before do
        fill_in "session_email", with: "wanwan@wan.com"
        fill_in "session_password", with: "wanwan"
        click_on "Log in"
        click_on "管理者画面へ"
      end
      it '管理ユーザはユーザの新規登録ができる' do
        click_on "新しくユーザーを登録する"
        fill_in "user_name", with: "cow"
        fill_in "user_email", with: "mowmow@mow.com"
        fill_in "user_password", with: "mowmow"
        fill_in "user_password_confirmation", with: "mowmow"
        click_on "登録する"
        click_on "登録する"
        expect(page).to have_content "ユーザーを作成しました！"
      end
      it '管理ユーザはユーザの詳細画面にアクセスができる' do
        click_on "確認",match: :first
        expect(page).to have_content "ユーザー内容画面"
      end
      it '管理ユーザはユーザの編集画面からユーザを編集ができる' do
        click_on "編集",match: :first
        fill_in "user_password", with: "mowmowmow"
        fill_in "user_password_confirmation", with: "mowmowmow"
        click_on "更新する"
        expect(page).to have_content "ユーザーを編集しました！"
      end
      it '管理ユーザはユーザの削除ができる' do
        click_on "削除",match: :first
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "ユーザーを削除しました！"
      end
    end
  end
end
