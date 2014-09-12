class CommandExecutor
  def initialize(attrs)
    @wall = attrs[:wall]
    @command = attrs[:command]
    raise ArgumentError.new 'Must have wall and command' unless @wall && @command
  end

  def run!
    SplatyMailer.wall_copy(@wall, 'leishman3@gmail.com')
  end
end