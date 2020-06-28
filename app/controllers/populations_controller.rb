class PopulationsController < ApplicationController
  def index
    if params[:year].present?
      @year = params[:year]
      @population = Population.get(@year.to_i)
    end
  end
end
