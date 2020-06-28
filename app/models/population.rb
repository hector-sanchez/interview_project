class Population < ApplicationRecord
  scope :last_known_prior_to_year, ->(year) { where('year < ?', max_year).where('year < ?', year).order(:year).last }
  
  GROWTH_RATE = 0.09.freeze
  MAX_YEAR = 2500.freeze

  class << self
    def get(year)
      return 0 if year < min_year
      
      pop = find_by_year(year)
    
      return pop.population if pop
      return future_population(year) if year > max_year
    
      computed_population(year)
    end
  end
  
  private
  
  def self.future_population(year)
    last_known  = order(:year).last
    last_population  = last_known.population
    (last_known.year..[MAX_YEAR, year].min).inject(last_population) do |lp, _|
      lp + (lp * GROWTH_RATE)
    end.to_i
  end
  
  def self.computed_population(year)
    (last_known_prior_to_year(year).population * rate(year)).to_i
  end

  def self.rate(year)
    following_year = available_years.select { |y| y > year }.first
    prior_year = available_years[available_years.index(following_year) - 1]
    ((following_year - prior_year) / prior_year.to_f) * 100
  end

  def self.available_years
    order(:year).pluck(:year).uniq
  end

  def self.min_year
    available_years.first
  end
  
  def self.max_year
    available_years.last
  end
end
