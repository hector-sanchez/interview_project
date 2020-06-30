require 'rails_helper'

RSpec.describe Log, type: :model do
  let(:instance) { build(:log) }

  it { should define_enum_for(:processed_as).with_values([:exact, :calculated]) }

  describe "scopes" do
    before do
      create(:log, year: 1900, processed_as: "exact")
      create(:log, year: 1900, processed_as: "exact")
      create(:log, year: 1902, processed_as: "calculated")
    end

    describe ".group_count_by_year" do
      subject { described_class.group_count_by_year }

      it { is_expected.to eq({ 1900 => 2, 1902 => 1 }) }
    end

    describe ".group_count_by_processed_as" do
      subject { described_class.group_count_by_processed_as }

      it { is_expected.to eq({ "exact" => 2, "calculated" => 1 }) }
    end
  end
end
