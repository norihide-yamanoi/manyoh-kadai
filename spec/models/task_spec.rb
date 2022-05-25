require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe '検索機能' do
    let!(:user) { FactoryBot.create(:admin_user) }
    let!(:task) { FactoryBot.create(:task, user: user) }
    let!(:second_task) { FactoryBot.create(:second_task, user: user) }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.search_name('０１')).to include(task)
        expect(Task.search_name('０１')).not_to include(second_task)
        expect(Task.search_name('０１').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_status('完了')).to include(task)
        expect(Task.search_status('完了')).not_to include(second_task)
        expect(Task.search_status('完了').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.search_name('０１').search_status('完了')).to include(task)
        expect(Task.search_name('０１').search_status('完了')).not_to include(second_task)
        expect(Task.search_name('０１').search_status('完了').count).to eq 1
      end
    end
  end
  describe 'バリデーションのテスト' do
    let!(:user) { FactoryBot.create(:admin_user) }
    let!(:task) { FactoryBot.create(:task, user: user) }
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(name: '', detail: '失敗テスト', user: user )
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: 'aaa', detail: '', user: user)
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        expect(task).to be_valid
      end
    end
  end
end
