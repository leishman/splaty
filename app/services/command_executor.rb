class CommandExecutor

  COMMAND_REGEXP = /[$]{2}/
  def initialize(attrs)
    @wall = attrs[:wall]
    @command = attrs[:command]
    raise ArgumentError.new 'Must have wall and command' unless @wall && @command
  end

  def run!
    command_arr = @command.split(' ')
    command = command_arr.shift.gsub(COMMAND_REGEXP, '')
    args = command_arr

    if command == 'email'
      SplatyMailer.wall_copy(@wall, args).deliver
    else
      return
    end
    
  end
end