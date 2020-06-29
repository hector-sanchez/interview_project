class Population < ApplicationRecord
  scope :last_known_prior_to_year, ->(year) { where('year < ?', last_recorded_year).where('year < ?', year).order(:year).last }
  
  GROWTH_RATE = 0.09.freeze
  MAX_YEAR = 2500.freeze

  attr_accessor :retrieved_as
  
  class << self
    def get(year)
      pop = find_by_year(year)
    
      if pop
        pop.retrieved_as = "exact"
        return pop
      end

      build_computed_population(year)
    end
    
    private

    def build_computed_population(year)
      pop = new(year: year)
      pop.population = get_population(year)
      pop.retrieved_as = "calculated"
      pop
    end

    def get_population(year)
      return 0 if year < min_year
      return future_population(year) if year > last_recorded_year
    
      computed_population(year)
    end
    
    def future_population(year)
      last_known  = order(:year).last
      last_population  = last_known.population
      (last_known.year..[MAX_YEAR, year].min).inject(last_population) do |lp, _|
        lp + (lp * GROWTH_RATE)
      end.to_i
    end
    
    def computed_population(year)
      (last_known_prior_to_year(year).population * yearly_difference_rate(year)).to_i
    end

    def yearly_difference_rate(year)
      following_year = available_years.select { |y| y > year }.first
      prior_year = available_years[available_years.index(following_year) - 1]
      ((following_year - prior_year) / prior_year.to_f) * 100
    end

    def available_years
      order(:year).pluck(:year).uniq
    end

    def min_year
      available_years.first
    end
    
    def last_recorded_year
      available_years.last
    end
  end
end
