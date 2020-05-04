require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(password: 'some_password',
                        email: 'john@doe.com',
                        name: 'john')
  end
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it 'is not valid without a email' do
    subject.email = nil
    expect(subject).to be_invalid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to be_invalid
  end

  it 'is not valid without a password' do
    subject.password = nil
    expect(subject).to be_invalid
  end

  it { should have_many(:posts) }
  it { should have_many(:comments) }
end
