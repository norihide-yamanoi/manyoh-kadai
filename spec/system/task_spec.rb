require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '検索機能' do
   before do
     FactoryBot.create(:task)
     FactoryBot.create(:second_task)
   end

    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
      visit tasks_path
      fill_in 'name', with: 'テスト'
      click_on '検索'
      expect(page).to have_content '０２'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select "完了", from: "number"
        click_on '検索'
        expect(page).to have_content '完了'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
      # ここに実装する
      visit tasks_path
      fill_in 'name', with: 'テスト'
      select "未着手", from: "number"
      click_on '検索'
      expect(page).to have_content '０２'
      expect(page).to have_content '未着手'
      end
    end
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[name]',with: 'test1'
        fill_in 'task[detail]',with: 'test2'
      #  select '2000', from: 'task[dead_line_1i]'
      #  select '3月', from: 'task[dead_line_2i]'
      #  select '10', from: 'task[dead_line_3i]'
        select '完了', from: 'task[status]'
        select '低', from: 'task[priority]'
        click_on "登録する"
        click_on "登録する"
        expect(page).to have_content 'test1'
        expect(page).to have_content 'test2'
        expect(page).to have_content '完了'
        expect(page).to have_content '低'

      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task)
        visit tasks_path
        expect(page).to have_content 'テストネーム０１'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task = FactoryBot.create(:task),FactoryBot.create(:second_task)
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'テストネーム０２'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task)
        visit tasks_path
        click_on "内容を確認する"
        expect(page).to have_content 'テストネーム０１'
      end
    end
  end

  describe 'ソート機能' do
    context '終了期限でソートするというリンクを押すと' do
      it "終了期限の降順に並び替えられたタスク一覧が表示される" do
        task = FactoryBot.create(:task),FactoryBot.create(:second_task)
        visit tasks_path
        click_on "終了期限でソートする"
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'テストネーム０２'
      end
    end
    context '優先順位でソートするというリンクを押すと' do
      it "優先順位の昇順に並び替えられたタスク一覧が表示される" do
        task = FactoryBot.create(:task),FactoryBot.create(:second_task)
        visit tasks_path
        click_on "優先順位でソートする"
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'テストネーム０２'
      end
    end
  end
end
