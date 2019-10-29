require 'rails_helper'

RSpec.feature 'タスク管理機能', type: :feature do
  background do
    @user = FactoryBot.create(:user)
    @task = FactoryBot.create(:task)
    @task2 = FactoryBot.create(:second_task)
    @task3 = FactoryBot.create(:third_task)
    visit new_session_path
    fill_in "session_email" ,with: "shiba@dic.com"
    fill_in "session_password", with: "shibaa"
    click_on "ログイン"
  end

  scenario 'タスク一覧のテスト' do
    visit tasks_path
    expect(page).to have_content 'titletitle1'
    expect(page).to have_content 'contentcontent1'
  end

  scenario 'タスク作成のテスト' do
    visit new_task_path
    fill_in "task_title", with: 'test_task_01'
    fill_in "task_content", with: 'testtesttest'
    click_on "作成する"
    expect(page).to have_content 'titletitle1'
    expect(page).to have_content 'contentcontent1'
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
    expect(tasks[2]).to have_content "titletitle1"
  end

  scenario "終了期限登録のテスト" do
    visit new_task_path

    fill_in "task_title", with: 'test_task_01'
    fill_in "task_content", with: 'testtesttest'
    select '2019', from: 'task_deadline_1i'
    select '12月', from: 'task_deadline_2i'
    select '12', from: 'task_deadline_3i'
    select '12', from: 'task_deadline_4i'
    select '30', from: 'task_deadline_5i'

    click_on '作成する'

    expect(page).to have_content '2019/12/12 12:30'
  end

  scenario "一覧画面で終了期限でソートテスト" do
    visit tasks_path
    click_link '期限順'

    tasks =  all(".task_list")
    expect(tasks[0]).to have_content "titletitle1"
    expect(tasks[1]).to have_content "titletitle2"
    expect(tasks[2]).to have_content "titletitle3"
  end

  scenario "一覧画面でステータス順でソートテスト" do
    visit tasks_path
    click_link 'ステータス順'

    tasks =  all(".task_list")
    expect(tasks[0]).to have_content "titletitle1"
    expect(tasks[1]).to have_content "titletitle2"
    expect(tasks[2]).to have_content "titletitle3"
  end

  scenario "タスクをステータスで絞り込みのテスト" do
    visit tasks_path
    select '完了', from: 'task_status'
    click_on 'register-button'
    expect(page).to have_content 'titletitle3'
  end

  scenario "一覧画面で優先順でソートテスト" do
    visit tasks_path
    click_link '優先順'

    tasks =  all(".task_list")
    expect(tasks[0]).to have_content "titletitle2"
    expect(tasks[1]).to have_content "titletitle1"
    expect(tasks[2]).to have_content "titletitle3"
  end

  scenario "ラベル単数検索" do
    @label = FactoryBot.create(:label)
    @label2 = FactoryBot.create(:second_label)
    LabelRelation.create!(task_id: @task.id, label_id: @label.id)
    LabelRelation.create!(task_id: @task2.id, label_id: @label.id)
    LabelRelation.create!(task_id: @task2.id, label_id: @label2.id)
    visit tasks_path
    fill_in "task_title", with: "titletitle1"
    select "未着手", from: "task_status"
    check "task_labels_ids_1"
    click_on 'register-button'
    expect(page).to have_content 'titletitle1'
  end

  scenario "ラベル複数検索" do
    @label = FactoryBot.create(:label)
    @label2 = FactoryBot.create(:second_label)
    LabelRelation.create!(task_id: @task.id, label_id: @label.id)
    LabelRelation.create!(task_id: @task2.id, label_id: @label.id)
    LabelRelation.create!(task_id: @task2.id, label_id: @label2.id)
    visit tasks_path
    select "着手中", from: "task_status"
    # find(:css, "#task_labels_ids_1[value='1']").set(true)
    # find(:css, "#task_labels_ids_2[value='2']").set(true)
    check "task_labels_ids_#{@label.id}"
    check "task_labels_ids_#{@label2.id}"
    click_on 'register-button'
    expect(page).to have_content 'titletitle2'
  end
end