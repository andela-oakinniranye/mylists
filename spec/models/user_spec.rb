require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    delete_test_user
  end

  it 'is valid with email and password' do
    user = User.create(valid_user_hash)

    expect(user).to be_valid
  end

  it 'is invalid without an email' do
    user = User.create(valid_user_hash.except(:email))

    expect(user).to be_invalid
  end

  it 'is invalid without a password' do
    user = User.create(valid_user_hash.except(:password))

    expect(user).to be_invalid
  end

  it 'generates a token everytime status is changed to logged in' do
    user = User.create(valid_user_hash)
    token1 = user.token

    user.logged_in!
    token2 = user.token

    expect(token1).not_to eq token2
  end

  it 'does not change token when logged out' do
    user = User.create(valid_user_hash)
    user.logged_in!
    token1 = user.token

    user.logged_out!
    token2 = user.token

    expect(token1).to eq token2
  end
end
