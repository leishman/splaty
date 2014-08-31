class WallsController < ApplicationController
  def index
    # POTENTIAL FUTURE UPDATE
  end

  def show
    @wall = Wall.find_by(path: params[:path])
  end

  def update
  end
end