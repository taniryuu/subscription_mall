require 'rails_helper'

RSpec.describe User, type: :model do

  it "ファクトリーボットが有効である事" do
    expect(FactoryBot.build(:user)).to be_valid
  end

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

  it "名前が無ければ無効" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include(I18n.t('errors.messages.blank'))
  end

  it "メールアドレスが無ければ無効" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include(I18n.t('errors.messages.blank'))
  end

  it "重複した’メールアドレスなら無効" do
    FactoryBot.create(:user, email: "sample@email.com")
    user = FactoryBot.build(:user, email: "sample@email.com")
    user.valid?
    expect(user.errors[:email]).to include(I18n.t('errors.messages.taken'))
  end

end
