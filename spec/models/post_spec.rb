# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should validate_presence_of(:trail) }
  it { should validate_presence_of(:park) }
end
