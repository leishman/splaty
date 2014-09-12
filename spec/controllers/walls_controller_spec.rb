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

    before(:each) do
      request.accept = "application/json"
    end

    it 'should update the wall' do
      wall_2 = FactoryGirl.create(:wall, path: 'new_wall')
      wall_3 = FactoryGirl.create(:wall, path: 'new_wall_2')
      put :update, { wall: { text: 'test test' }, path: wall_2.path }, format: :json
      expect(response.status).to eq 200
      expect(wall_2.reload.text).to eq 'test test'
    end
  end

  describe 'POST #command' do

    before(:each) do
      request.accept = "application/json"
    end

    context 'command fails' do
      it "should return a failed response" do
        CommandExecutor.any_instance.stub(:run!).and_return({ success: false })
        post :command, { wall: { command: 'notacommand sldfaksf'}, path: @wall.path }, format: :json
        expect(response.status).to eq 406

        expected_response_body = { success: false }.to_json
        expect(response.body).to eq expected_response_body
      end
    end

    context 'command succeeds' do
      it  "should return a successful response" do
        CommandExecutor.any_instance.stub(:run!).and_return({success: true, message: 'Your email has been sent'})
        post :command, { wall: { command: 'email leishman@splaty.com'}, path: @wall.path }, format: :js
        expect(response.status).to eq 200

        expected_response_body = { success: true, message: 'Your email has been sent'}.to_json
        expect(response.body).to eq(expected_response_body)
      end
    end
  end
end
