require 'rails_helper'

RSpec.describe Bucketlist, type: :model do
  let(:valid_bucketlist_params){ {name: verb_ing, user: valid_user} }
  let(:valid_saved_bucketlist){ bucketlist = new_valid_bucketlist; bucketlist.save; bucketlist }
  let(:valid_bucketlist){ new_valid_bucketlist }
  let(:valid_item){ new_valid_item }

  it 'is invalid without a name' do
    bucketlist = valid_user.bucketlists.create

    expect(bucketlist).to be_invalid

    bucketlist.name = verb_ing
    bucketlist.save

    expect(bucketlist).to be_valid
  end

  it 'is invalid without a user' do
    bucketlist = Bucketlist.create(name: verb_ing)

    expect(bucketlist).to be_invalid

    bucketlist.user = valid_user
    bucketlist.save

    expect(bucketlist).to be_valid
  end

  it 'is valid with a user and a name' do
    expect(valid_saved_bucketlist).to be_valid
  end

  it 'can have many items' do
    bucketlist = valid_bucketlist
    num_of_valid_items = 3

    expect{
      num_of_valid_items.times{
        bucketlist.items << new_valid_item
      }
      bucketlist.save
    }.to change(valid_bucketlist.items, :count).by(num_of_valid_items)
  end
end
