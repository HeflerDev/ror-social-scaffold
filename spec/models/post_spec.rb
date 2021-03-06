require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(email: 'q@werty', name: 'qwerty', password: 'qwerty') }
  subject do
    described_class.new(
      user_id: user.id,
      content: 'lorem ipsum'
    )
  end
  it 'should be valid' do
    expect(subject).to be_valid
  end

  it 'should be invalid without content' do
    subject.content = nil
    expect(subject).to be_invalid
  end

  it 'should be invalid without user id' do
    subject.user_id = nil
    expect(subject).to be_invalid
  end

  # rubocop:disable Layout/LineLength

  it 'should be invalid when exceed number os characters' do
    subject.content = 'volutpat blandit aliquam etiam erat velit scelerisque in dictum non consectetur a erat nam at lectus urna duis convallis convallis tellus id interdum velit laoreet id donec ultrices tincidunt arcu non sodales neque sodales ut etiam sit amet nisl purus in mollis nunc sed id semper risus in hendrerit gravida rutrum quisque non tellus orci ac auctor augue mauris augue neque gravida in fermentum et sollicitudin ac orci phasellus egestas tellus rutrum tellus pellentesque eu tincidunt tortor aliquam nulla facilisi cras fermentum odio eu feugiat pretium nibh ipsum consequat nisl vel pretium lectus quam id leo in vitae turpis massa sed elementum tempus egestas sed sed risus pretium quam vulputate dignissim suspendisse in est ante in nibh mauris cursus mattis molestie a iaculis at erat pellentesque adipiscing commodo elit at imperdiet dui accumsan sit amet nulla facilisi morbi tempus iaculis urna id volutpat lacus laoreet non curabitur gravida arcu ac tortor dignissim convallis aenean et tortor at risus viverra adipiscing at in tellus integer feugiat scelerisque varius morbi enim nunc faucibus a pellentesque sit amet porttitor eget dolor morbi non arcu risus quis varius quam quisque id diam vel quam elementum pulvinar etiam non quam lacus suspendisse faucibus interdum posuere lorem'
    expect(subject).to be_invalid
  end

  # rubocop:enable Layout/LineLength

  it { should belong_to(:user) }
  it { should have_many(:comments) }
end
