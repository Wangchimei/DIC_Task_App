require 'rails_helper'

RSpec.feature "user sign up and login", type: :feature do
  background do
    @user = FactoryBot.create(:user)
  end

  scenario "user registration"  do
    visit new_user_path
    fill_in "user_name" , with: "Bob"
    fill_in "user_email", with: "bobsburger@dic.com"
    fill_in "user_password", with: "burger"
    fill_in "user_password_confirmation", with: "burger"
    click_on "登録する"
    expect(page).to have_content "タスク一覧"
    expect(page).to have_content "ログインしました"
  end

  scenario "error message for all invalid fields" do
    visit new_user_path
    click_on "登録する"
    expect(page).to have_content "パスワードを入力してください"
    expect(page).to have_content "パスワードは6文字以上で入力してください"
    expect(page).to have_content "名前を入力してください"
    expect(page).to have_content "メールアドレスを入力してください"
    expect(page).to have_content "メールアドレスは不正な値です"
  end

  scenario  "fail to login", open_on_error: true do
    visit new_session_path
    fill_in "session_email" ,with: "shiba@dic.com"
    fill_in "session_password", with: "shibacute"
    click_on "ログイン"
    expect(page).to have_content "メールアドレスまたはパスワードが違います"
  end

  scenario "require sign in for accessing views" do
    visit tasks_path
    expect(page).to have_content "ログインしてください"
  end
end

RSpec.feature "after user login", type: :feature do
  background do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:other_user)
    visit new_session_path
    fill_in "session_email" ,with: "shiba@dic.com"
    fill_in "session_password", with: "shibaa"
    click_on "ログイン"
  end

  scenario "check login status" do
    expect(page).to have_content "ログインしました"
  end

  scenario "deny access to sign up page" do
    visit new_user_path
    expect(page).to have_content "既にログイン中です"
  end

  scenario "deny access to login page" do
    visit new_session_path
    expect(page).to have_content "既にログイン中です"
  end

  scenario "able to see user page" do
    click_on "マイページ"
    expect(page).to have_content "Shiba"
  end

  scenario "deny access to another user's page" do
    visit user_path(@other_user)
    expect(page).to have_content "権限がありません"
  end

  scenario "able to logout" do
    click_on "ログアウト"
    expect(page).to have_content "ログアウトしました"
  end
end

RSpec.feature "privacy", type: :feature do
  background do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:other_user)
    @task_by_user = FactoryBot.create(:task_by_user)
    @task_by_other_user = FactoryBot.create(:task_by_other_user)
    visit new_session_path
    fill_in "session_email" ,with: "shiba@dic.com"
    fill_in "session_password", with: "shibaa"
    click_on "ログイン"
  end

  scenario "unable to see another user's task" do
    expect(page).to have_content "myself"
    expect(page).not_to have_content "other user"
  end
end