module BucketlistSetup
  def random_bucketlist
    Bucketlist.limit(1).offset(rand(Bucketlist.count)).first
  end

  def new_valid_bucketlist
    Bucketlist.new name: verb_ing, user: valid_user
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
