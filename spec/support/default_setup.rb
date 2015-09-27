RSpec.configure do |config|
  config.before do
    load 'db/seeds.rb'
  end

  config.before(:each) do
    reset_users
    setup_valid_user
  end
end



RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include MakeRequest, type: :request
  config.include JsonHelpers, type: :request
  config.include BucketlistSetup
  config.include UserSetupHelpers
end


# reset_users
# valid_user

  # config.before do
  #   FactoryGirl.define do
  #     sequence :email do |n|
  #       "email_for#{n}@example.com"
  #     end
  #     require 'pry' ; binding.pry
  #     factory :user do
  #       name "John"
  #       email
  #     end
  #   end
  # end


# {authorization: "Token token=#{auth_token}"}
