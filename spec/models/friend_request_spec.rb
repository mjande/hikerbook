require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  subject { FriendRequest.new(sender: create(:user), receiver: create(:friend)) }

  it { should belong_to(:sender) }
  it { should belong_to(:receiver) }
end
