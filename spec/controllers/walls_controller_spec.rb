require 'rails_helper'

RSpec.describe WallsController, :type => :controller do
  before do
    @wall = FactoryGirl.create(:wall)
  end
  describe 'GET #show' do

    it 'should render existing wall if it exists' do
      get :show, path: @wall.path
      expect(response.status).to eq 200
      expect(response).to render_template :show
    end

    it 'should create new wall if wall does not exist' do
      get :show, path: 'does_not_exist'
      expect(response.status).to eq 200
      expect(response).to render_template :show
    end

    it 'should redirect to the root path if the path name is invalid' do
      get :show, path: 'inavlid^&'
      expect(response).to redirect_to root_path
    end
  end

  describe 'PUT #update' do
    it 'should update the wall' do
      wall_2 = FactoryGirl.create(:wall, path: 'new_wall')
      wall_3 = FactoryGirl.create(:wall, path: 'new_wall_2')
      put :update, { wall: { text: 'test test' }, id: wall_2.id }, format: :js
      expect(wall_2.reload.text).to eq 'test test'
    end
  end
end
