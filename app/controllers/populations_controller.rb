class PopulationsController < ApplicationController
  after_action :log, if: :getting_population?

  def index
    if getting_population?
      @year = params[:year]
      @population = Population.get(@year.to_i)
    end
  end

  private

  def log
    Log.create(year: @year, population: @population)
  end

  def getting_population?
    params[:year].present?
  end
end
