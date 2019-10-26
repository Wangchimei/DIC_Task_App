require 'rails_helper'

RSpec.describe User, type: :model do
  it "nameが空ならバリデーションが通らない" do
    user = User.new(name:'', email:"test@test.com", password_digest:"111111")
    expect(user).not_to be_valid
  end

  it "emailが空ならバリデーションが通らない" do
    user = User.new(name:"A", email:'', password_digest:"111111")
    expect(user).not_to be_valid
  end

  it "emailのフォーマットでバリデーションが通らない"  do
    user = User.new(name:"A", email:"111111", password_digest:"111111")
    expect(user).not_to be_valid
  end

  it "passwordが空ならバリデーションが通らない" do
    user = User.new(name:"A", email:"test@test.com", password_digest:'')
    expect(user).not_to be_valid
  end

  it "passwordの長さが足りないならバリデーションが通らない" do
    user = User.new(name:"A", email:"test@test.com", password_digest:"111")
    expect(user).not_to be_valid
  end

  it "登録されているemailを使ったらバリデーションが通らない" do
    user1 = User.new(name:"A", email:"test@test.com", password_digest:"111111")
    user2 = User.new(name:"B", email:"test@test.com", password_digest:"222222")
    expect(user2).not_to be_valid
  end
end
