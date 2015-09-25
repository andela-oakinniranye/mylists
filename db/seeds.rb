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

12.times{
  b = Bucketlist.create(name: Faker::Hacker.ingverb)
  rand(0..10).times{
    Item.create(name: Faker::Hacker.say_something_smart, status: Item.statuses.values.sample, bucketlist: b)
  }
}
