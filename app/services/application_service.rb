class ApplicationService
  def initialize(options = {})
    @options = options
  end

  def self.call(*args, &block)
    new(*args, &block).call
  end
end
