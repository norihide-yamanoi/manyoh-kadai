require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
#  let!(:label) { FactoryBot.create(:label) }
  let!(:label2) { FactoryBot.create(:label2) }
  let!(:user) { FactoryBot.create(:admin_user) }
  let!(:task) { FactoryBot.create(:task, user: user)}
  before do
    visit new_session_path
    fill_in "session[email]",with: "wanwan@wan.com"
    fill_in "session[password]",with: "wanwan"
    click_on "Log in"
  end

  # describe '新規作成機能' do
  #   context 'ラベルを新規作成した場合' do
  #     it '作成したラベルが表示される' do
  #       visit labels_path
  #       click_on "New Label"
  #       fill_in "label[name]",with: "abc"
  #       click_on "登録する"
  #       expect(page).to have_content 'Label was successfully created.'
  #     end
  #   end
  # end
  #
  # describe '一覧表示機能' do
  #   context '一覧画面に遷移した場合' do
  #     it '作成済みのラベル一覧が表示される' do
  #       visit labels_path
  #       expect(page).to have_content '朝'
  #     end
  #   end
  # end

  describe '登録機能' do
    context 'タスクを新規登録するとき' do
      it 'ラベルも複数登録できる' do
        visit new_task_path
        fill_in 'task[name]',with: 'test1'
        fill_in 'task[detail]',with: 'test2'
        select '完了', from: 'task[status]'
        select '低', from: 'task[priority]'
        check '朝'
        check '昼'
        click_on "登録する"
        #confirm
        expect(page).to have_content '朝'
        expect(page).to have_content '昼'
      end
    end
    # context 'タスクの詳細画面に遷移したとき' do
    #   it 'ラベルも確認できる' do
    #     visit tasks_path
    #     click_on "確認"
    #     expect(page).to have_content '朝'
    #   end
    # end
  end

  # describe '検索機能' do
  #   context 'ラベル検索をクリックすると' do
  #     it 'そのラベルを持つタスクが表示される' do
  #       visit tasks_path
  #       select '朝'
  #       click_on '検索'
  #       expect(page).to have_content '朝'
  #     end
  #   end
  # end
end
