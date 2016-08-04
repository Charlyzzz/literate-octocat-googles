class SingleDependency

  attr_writer :is_available

  def initialize(name, size, available = false)
    @name = name
    @size = size
    @is_available = available
  end

  def download
    raise 'Already downloaded' if available?
    @is_available = true
  end

  def download_size
    @size
  end

  def available?
    @is_available
  end

end

class MultiDependency

  def initialize(name, *dependencies)
    @name = name
    @dependencies = dependencies
  end

  def download
    raise 'Already downloaded' if available?
    missing_dependencies.each { |dependency| dependency.download }
  end

  def download_size
    missing_dependencies.reduce(0) { |size, dependency| size + dependency.download_size }
  end

  def available?
    @dependencies.all? { |dependency| dependency.available? }
  end

  def missing_dependencies
    @dependencies.reject { |dependency| dependency.available? }
  end

end