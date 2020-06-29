require 'rails_helper'

RSpec.describe Population, type: :model do
  before do
    create(:population, year: 1900, population: 76_212_168)
    create(:population, year: 1990, population: 248_709_873)
    create(:population, year: 1902, population: 76_212_168)
    create(:population, year: 1909, population: 76_212_168)
  end

  it "should accept a year we know and return the correct population" do
    expect(Population.get(1900).population).to eq(76212168)
    expect(Population.get(1990).population).to eq(248709873)
  end
  
  it "should accept a year we don't know and return the previous known population" do
    expect(Population.get(1902).population).to eq(76212168)
    expect(Population.get(1990).population).to eq(248709873)
    expect(Population.get(1991).population).to eq(295492200)
  end

  it "should accept a year that is before earliest known and return zero" do
    expect(Population.get(1800).population).to eq(0)
    expect(Population.get(0).population).to eq(0)
    expect(Population.get(-1000).population).to eq(0)
  end

  it "should accept a year that is after latest known and return the last known population" do
    expect(Population.get(2000).population).to eq(641777523)
    expect(Population.get(2499).population).to eq(3042334591789727409109991424)
    expect(Population.get(2500).population).to eq(3316144705050802837446983680)
    expect(Population.get(2501).population).to eq(3316144705050802837446983680)
  end

  describe ".last_known_prior_to_year" do
    let(:expected_population) { Population.find_by_year(1900) }

    subject { Population.last_known_prior_to_year(1901) }

    it { is_expected.to eq expected_population }
  end

end
