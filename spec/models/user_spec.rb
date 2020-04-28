require 'rails_helper'

RSpec.describe User, :type => :model do
  it "is valid with valid attributes" do
    expect(User.new(email:'a@sdf',name:'asdf', password:'asdfgh')).to be_valid
  end
  it "is not valid without a email" do
      expect(User.new(name:'asdf', password:'asdfgh')).to be_invalid
  end

  it "is not valid without a name" do
    expect(User.new(password:'asdfgh',email:'a@sdf')).to be_invalid
  end

  it "is not valid without a password" do
    expect(User.new(email:'a@sdf', name:'asdf')).to be_invalid
  end
end
