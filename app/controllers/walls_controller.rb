class WallsController < ApplicationController

  before_filter :redirect_if_invalid_path, only: :show

  def index
    # POTENTIAL FUTURE UPDATE
  end

  def show
    @wall = Wall.find_or_create_by(path: @path)
  end

  def update
    @wall.update_attributes wall_attrs
  end

  private

    def wall_attrs
      params.require(:wall).permit(:text)
    end

    def redirect_if_invalid_path
      @path = params[:path].downcase
      path_name_value = PathName.new(@path)
      redirect_to root_path unless path_name_value.valid?
    end
end