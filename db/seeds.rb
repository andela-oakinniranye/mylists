# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Bucketlist.destroy_all
Bucketlist.reset_pk_sequence
Item.destroy_all
Item.reset_pk_sequence

test_email = 'oreoluwa@outlook.com'
user = User.where(email: test_email).first
user.destroy if user
ore = User.create(name: 'Oreoluwa', email: test_email, password: 'oreoluwa')

12.times{
  b = ore.bucketlists.create!(name: Faker::Hacker.ingverb)
  rand(0..10).times{
    Item.create(name: Faker::Hacker.say_something_smart, status: Item.statuses.values.sample, bucketlist: b)
  }
}
