module BucketlistSetup
  def seed
    load 'db/seeds.rb'
  end

  def random_bucketlist
    Bucketlist.random
  end

  def random_bucketlist_that_does_not_belong_to_user
    Bucketlist.where.not(user: valid_user).random
  end

  def new_valid_bucketlist
    Bucketlist.new name: verb_ing, user: valid_user
  end

  def usable_bucketlist
    bucketlist = new_valid_bucketlist
    bucketlist.save
    bucketlist
  end

  def new_valid_item
    Item.new name: smart_word, status: rand(2)
  end

  def smart_word
    Faker::Hacker.say_something_smart
  end

  def verb_ing
    Faker::Hacker.ingverb
  end
end
