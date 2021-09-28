require "json"

class Config
  def initialize(logger:)
    @logger = logger
  end

  def minimum_difficulty
    ENV['MINIMUM_DIFFICULTY'] || 'Medium'
  end
end
