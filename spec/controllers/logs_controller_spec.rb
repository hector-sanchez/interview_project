require 'rails_helper'

RSpec.describe LogsController, type: :controller do
  it "returns http success and renders correct template" do
    get :index

    expect(response).to render_template("index")
    expect(response).to have_http_status(:success)
    expect(assigns(:logs)).to eq Log.all
    expect(assigns(:logs_by_processed_as)).not_to be_nil
    expect(assigns(:logs_by_year)).not_to be_nil
  end
end
