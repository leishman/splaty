class WallsController < ApplicationController
  def index
    # POTENTIAL FUTURE UPDATE
  end

  def show
    path = params[:path].downcase
    @wall = Wall.find_or_create_by(path: path)
  end

  def update
    @wall.update_attributes wall_attrs
  end

  private

    def wall_attrs
      params.require(:wall).permit(:text)
    end
end