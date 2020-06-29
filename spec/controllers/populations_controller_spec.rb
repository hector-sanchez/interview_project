require 'rails_helper'

RSpec.describe PopulationsController, type: :controller do
  before do
    create(:population, year: 1900)
  end 

  render_views

  describe "GET #index" do
    let(:year) { 1900 }

    it "returns http success" do
      get :index
      
      expect(response).to have_http_status(:success)
    end

    it "returns http success and renders correct template" do
      get :index, params: { year: year }

      expect(response).to render_template("index")
      expect(response).to have_http_status(:success)
    end
  
    it "returns a population for a date" do
      get :index, params: { year: year }

      expect(assigns(:year)).to eq "1900"
      expect(assigns(:population)).to eq Population.get(year)
    end

    it "logz" do
      expect { get :index, params: { year: year } }.to change { Log.count }.by(1)
    end
    
    it "does NOT log" do
      expect { get :index }.not_to change { Log.count }
    end
  end
end
