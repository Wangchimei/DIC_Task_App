require 'rails_helper'
require 'byebug'

RSpec.feature 'タスク管理機能', type: :feature do
  background do
    @task = FactoryBot.create(:task)
    @task2 = FactoryBot.create(:second_task)
    @task3 = FactoryBot.create(:third_task)
  end

  scenario 'タスク一覧のテスト', open_on_error: true do
    visit tasks_path

    expect(page).to have_content 'titletitle1'
    expect(page).to have_content 'contentcontent1'
  end

  scenario 'タスク作成のテスト', open_on_error: true do
    visit new_task_path

    fill_in "task_title", with: 'test_task_01'
    fill_in "task_content", with: 'testtesttest'
    click_on "作成する"
    expect(page).to have_content 'test_task_01'
    expect(page).to have_content 'testtesttest'
  end

  scenario 'タスク詳細のテスト', open_on_error: true do
    visit task_path(@task3)

    expect(page).to have_content 'titletitle3'
    expect(page).to have_content 'contentcontent3'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    visit tasks_path

    tasks =  all(".task_list")
    expect(tasks[0]).to have_content "titletitle3"
    expect(tasks[1]).to have_content "titletitle2"
  end
end