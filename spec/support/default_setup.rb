RSpec.configure do |config|
  config.before do
    seed
  end

  config.before(:each) do
    reset_users
    seed if Bucketlist.count == 0
    setup_valid_user
  end
end



RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include JsonHelpers
  config.include BucketlistSetup
  config.include UserSetupHelpers
  config.include CustomErrorMessages
  config.include MakeRequest, type: :request
  config.include ControllerHelperMethods, type: :controller
end
