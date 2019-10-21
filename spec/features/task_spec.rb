require 'rails_helper'
require 'byebug'

RSpec.feature 'タスク管理機能', type: :feature do
  scenario 'タスク一覧のテスト', open_on_error: true do
  Task.create!(title: 'test_task_01', content: 'testtesttest')
  Task.create!(title: 'test_task_02', content: 'samplesample')

  visit tasks_path

  expect(page).to have_content 'testtesttest'
  expect(page).to have_content 'samplesample'
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
    Task.create!(title: 'test_task_01', content: 'testtesttest')
    visit tasks_path
    click_on '詳細'
    expect(page).to have_content 'test_task_01'
    expect(page).to have_content 'testtesttest'
  end
end