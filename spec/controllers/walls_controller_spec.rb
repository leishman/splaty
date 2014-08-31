require 'rails_helper'

RSpec.describe WallsController, :type => :controller do
  describe "GET #show" do

    before(:each) do
      @wall = FactoryGirl.create(:wall)
    end

    it "should render existing wall if it exists" do
      get :show, path: @wall.path
      expect(response.status).to eq 200
      expect(response).to render_template :show
    end

    it "should create new wall if wall doesn't exist" do
      get :show, path: 'does_not_exist'
      expect(response.status).to eq 200
      expect(response).to render_template :show
    end
  end
end
