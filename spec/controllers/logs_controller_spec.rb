require 'rails_helper'

RSpec.describe LogsController, type: :controller do
  it "returns http success and renders correct template" do
    get :index

    expect(response).to render_template("index")
    expect(response).to have_http_status(:success)
  end
end
