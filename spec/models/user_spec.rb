require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  # 有効なユーザかどうかのテスト
  it 'it is a valid User' do
    expect(user).to be_valid
  end

  # バリデーションテスト
  it 'is invalid with no name' do
    user.name = ' '
    expect(user).to be_invalid
  end

  it 'is invalid with no email' do
    user.email = ' '
    expect(user).to be_invalid
  end

  # 長さに対するテスト
  it 'is invalid with 51-letter names' do
    user.name = 'a' * 51
    expect(user).to be_invalid
  end

  it 'is invalid with 255-letter emails' do
    user.email = 'a' * 244 + '@example.com'
    expect(user).to be_invalid
  end

  # emailのフォーマットに対するテスト
  it 'is invalid with the wrong email\'s format' do
    invalid_addresses = %w(user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com user@example..com)
    invalid_addresses.each do |invalid_address|
      user.email = invalid_address
      expect(user).to be_invalid
    end
  end

  # 大文字小文字を区別しない一意性のテスト
  it "is invalid with registered email" do
    duplicate_user = user.dup
    # 全て大文字で保存する
    duplicate_user.email = user.email.upcase
    user.save
    expect(duplicate_user).to be_invalid
  end

  # passwordの最小文字テスト
  it 'is invalid with no password' do
    user.password = user.password_confirmation = ' ' * 6
    expect(user).to be_invalid
  end

  it 'is invalid with 5-letter passwords' do
    user.password = user.password_confirmation = 'a' * 5
    expect(user).to be_invalid
  end

  # ダイジェストが存在しない場合のauthenticated?のテスト
  it 'returns false for a user with nil digest' do
    expect(user.authenticated?('')).to be_falsy
  end
end
