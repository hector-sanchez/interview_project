class PopulationsController < ApplicationController
  def index
  end

  def show
    @year = params[:year]
    @population = Population.get(@year.to_i)
  end
end
