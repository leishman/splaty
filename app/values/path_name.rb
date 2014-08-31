class PathName
  def initialize(name)
    @name = name
  end

  PATH_BLACKLIST = ['about', 'terms', 'security', 'buy', 'pay', 'store', 'home', 'mystery']
  PATH_REGEXP = /\A\w{1,35}\Z/

  def valid?
    if !PATH_BLACKLIST.include?(@name) && @name =~ PATH_REGEXP
      true
    else
      false
    end
  end

end
