require 'rails_helper'

RSpec.describe Log, type: :model do
  let(:instance) { build(:log) }

  # I wouldn't normally do this, but I also don't want to NOT test anything here
  it "has year and population" do
    expect(instance).to respond_to(:year)
    expect(instance).to respond_to(:population)
  end
end
