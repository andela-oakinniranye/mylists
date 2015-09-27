require 'rails_helper'

RSpec.describe Item, type: :model do

  it 'is invalid without a name' do
    item = Item.create(status: 0)

    expect(item).to be_invalid
  end

  it 'is invalid without a status' do
    item = Item.create(name: smart_word)

    expect(item).to be_invalid
  end

  it 'is invalid without a bucketlist' do
    item = Item.create(name: smart_word, status: 1)

    expect(item).to be_invalid
  end

  it 'is valid with a name, status and bucketlist' do
    item = new_valid_item
    item.bucketlist = random_bucketlist
    item.save

    expect(item).to be_valid
  end

end
