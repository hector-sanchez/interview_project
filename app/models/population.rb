class Population < ApplicationRecord

  scope :last_known_prior_to_year, ->(year) { where('year < ?', max_year).where('year < ?', year).order(:year).last }

  def self.get(year)
    return 0 if year < min_year
    
    population = find_by_year(year)

    return population.population if population
    return order(:year).last.population if year > max_year
  
    last_known_prior_to_year(year).population
  end

  private

  def self.min_year
    order(:year).first.year
  end

  def self.max_year
    order(:year).last.year
  end
end
