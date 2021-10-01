# location: spec/unit/unit_spec.rb
require 'rails_helper'

RSpec.describe Book, type: :model do
  subject do
    described_class.new(title: 'harry potter', author: 'Hatsune Miku', price: 12.99, published: Date.new(1997, 06, 26))
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid

    other_title = 'cows_in_space'
    subject.title, other_title = other_title, subject.title
    expect(subject).to be_valid
    subject.title = other_title

    other_author = 'harr1son ford'
    subject.author, other_author = other_author, subject.author
    expect(subject).to be_valid
    subject.author = other_author

    other_price = 0
    subject.price, other_price = other_price, subject.price
    expect(subject).to be_valid
    subject.price = other_price

    other_published = Date.new(2022, 02, 02)
    subject.published, other_published = other_published, subject.published
    expect(subject).to be_valid
    subject.published = other_published

  end

  it 'is not valid without a name' do
    subject.title = nil
    expect(subject).not_to be_valid
    subject.title = ''
    expect(subject).not_to be_valid
    subject.title = 'harry potter'
  end

  it 'is not valid without an author' do
    subject.author = nil
    expect(subject).not_to be_valid
    subject.author = ''
    expect(subject).not_to be_valid
    subject.author = 'Hatsune Miku'
  end

  it 'is not valid without a price' do
    subject.price = nil
    expect(subject).not_to be_valid
    subject.price = 12.99
  end

  it 'is not valid with a negative price' do
    subject.price = -1
    expect(subject).not_to be_valid
    subject.price = 12.99
  end

  it 'is not valid with a non-numeric price' do
    subject.price = 'One of your finest cows!'
    expect(subject).not_to be_valid
    subject.price = 12.99
  end
end
