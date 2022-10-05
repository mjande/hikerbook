# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  subject { described_class.new(sender: create(:user), receiver: create(:friend)) }

  it { should belong_to(:sender) }
  it { should belong_to(:receiver) }
end
