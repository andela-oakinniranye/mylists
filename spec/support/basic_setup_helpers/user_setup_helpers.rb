module UserSetupHelpers
  # attr_reader :valid_user_hash

  # def valid_user
  #   user = User.find_by(valid_user_hash[:email])
  #   user.logged_in!
  # end

  def setup_valid_user
    delete_test_user
    user = User.create!(valid_user_hash)
    user.logged_in!
    user
  end

  def valid_user
    User.find_by_email(valid_user_hash[:email])
  end


  def delete_test_user
    test_email = valid_user_hash[:email]
    user = User.where(email: test_email).first
    user.destroy if user
  end

  def valid_user_hash
    {name: 'ikem', email: 'ikem@andela.com', password: 'ikem'}
  end

  def reset_users
    User.destroy_all
    User.reset_pk_sequence
  end

end
