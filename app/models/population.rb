class Population < ApplicationRecord
  scope :last_known_prior_to_year, ->(year) { where('year < ?', max_year).where('year < ?', year).order(:year).last }
  
  class << self
    def get(year)
      return 0 if year < min_year
      
      pop = find_by_year(year)
    
      return pop.population if pop
      return last_known_population if year > max_year
    
      computed_population(year)
    end
  end
  
  private
  
  def self.last_known_population
    order(:year).last&.population
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
