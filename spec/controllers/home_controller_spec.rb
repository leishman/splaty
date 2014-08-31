require 'rails_helper'

RSpec.describe HomeController, :type => :controller do
  describe "GET #index" do
    it "should return success" do
      get :index
      expect(response.status).to eq 200
      expect(response).to render_template(:index)
    end
  end
end
