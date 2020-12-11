require 'rails_helper'

RSpec.describe User, type: :model do

  it "名前、メール、パスワードがある場合、有効である" do
    # userのそれぞれのカラムに対して値を入れてオブジェクト化する
    user = User.new(
     name: "testname",
     email: "testname@example.com",
     password: "password",
     )
     # オブジェクトをexpectに渡した時に、有効である(be valid)という意味になります
     expect(user).to be_valid
  end

  it "名前がない場合、無効である"
  it "メールアドレスがない場合、無効である" 
  it "重複したメールアドレスの場合、無効である"
  it "パスワードがない場合、無効である"

end