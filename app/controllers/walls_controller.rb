class WallsController < ApplicationController

  before_filter :redirect_if_invalid_path, only: :show

  def index
    # POTENTIAL FUTURE UPDATE
  end

  # Show any wall with a valid path
  def show
    @wall = Wall.find_or_create_by(path: @path)
  end

  # PUT to update a wall's contents
  def update
    wall = Wall.find_by(path: params[:path])

    respond_to do |format|
      if wall.update_attributes wall_attrs
        flash[:notice] = 'Update Successful'
        format.html { redirect_to wall_path wall }
        format.json { render json: { success: status, state: 'Saved' }, status: 200 }
      else
        flash[:notice] = 'Update Failed'
        format.html { redirect_to wall_path wall }
        format.json { render json: { success: status }, status: 406 }
      end
    end
  end

  # POST a command to be run by CommandExecutor
  def command
    wall = Wall.find_by(path: params[:path])
    cmd = params[:wall][:command]
    ce = CommandExecutor.new(wall: wall, command: cmd)

    result = ce.run!
    respond_to do |format|
      if result[:success]
        flash[:notice] = 'Command Successful'
        format.html { redirect_to wall_path wall }
        format.json { render json: result, status: 200 }
      else
        flash[:notice] = 'Command Failed'
        format.html { redirect_to wall_path wall }
        format.json { render json: result, status: 406 }
      end
    end
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