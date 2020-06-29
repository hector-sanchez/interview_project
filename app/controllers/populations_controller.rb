class PopulationsController < ApplicationController
  after_action :log, if: :getting_population?

  def index
    if getting_population?
      pop = Population.get(params[:year].to_i)
      @year = pop.year
      @population = pop.population
      @retrieved_as = pop.retrieved_as
    end
  end

  private

  def log
    Log.create(year: @year, population: @population, processed_as: @retrieved_as)
  end

  def getting_population?
    params[:year].present?
  end
end
