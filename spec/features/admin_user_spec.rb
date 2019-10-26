require 'rails_helper'

RSpec.feature "admin user", type: :feature do
  background do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:other_user)
    visit new_session_path
    fill_in "session_email" ,with: "chiitan@dic.com"
    fill_in "session_password", with: "chiitan"
    click_on "ログイン"
  end

  scenario "check admin status"  do
    expect(page).to have_content "admin"
    expect(page).to have_content "ユーザー管理"
  end

  scenario "able to see all registered users" do
    visit admin_users_path
    expect(page).to have_content "Shiba"
    expect(page).to have_content "Chiitan"
  end

  scenario "create new user" do
    visit admin_users_path
    click_on "ユーザーを作成"
    fill_in "user_name" , with: "Bob"
    fill_in "user_email", with: "bobsburger@dic.com"
    fill_in "user_password", with: "burger"
    fill_in "user_password_confirmation", with: "burger"
    select "なし", from: "user_admin"
    click_on "作成する"
    expect(page).to have_content "Bob"
  end

  scenario "edit existing user" do
    visit admin_users_path
    click_link "edit_2"
    fill_in "user_name" ,with: "ちぃたん"
    fill_in "user_email",with: "chiitan@gmail.com"
    click_on "更新する"
    expect(page).to have_content "ちぃたん"
    expect(page).to have_content "chiitan@gmail.com"
  end

  scenario "delete existing user" do
    visit admin_users_path
    click_link "dlt_2"
    expect(page).to have_content "ユーザーを削除しました"
  end

  scenario "able to see another user's tasks" do
    task = Task.create!(
      title: "other user",
      content: "other user",
      deadline: DateTime.now,
      user_id: @other_user.id
    )
    visit task_path(task.id)
    expect(page).to have_content "other user"
  end
end