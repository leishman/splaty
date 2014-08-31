require 'rails_helper'

RSpec.describe WallsController, :type => :controller do
  describe "GET #show" do

    before(:each) do
      @wall = FactoryGirl.create(:wall)
    end

    it "should render success despite path" do
      get :show, path: @wall.path
      expect(response).to render_template :show
    end
  end
end
