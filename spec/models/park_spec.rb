require 'rails_helper'

RSpec.describe Park, type: :model do
  it { should validate_presence_of(:name) }
  it { should have_one_attached(:image) }
end
