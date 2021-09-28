class App
  def initialize(
    logger:,
    leetcode:,
    wikipedia_algorithms:
  )
    @logger = logger
    @leetcode = leetcode
    @wikipedia_algorithms = wikipedia_algorithms
  end

  def wikipedia_algorithm
    @wikipedia_algorithms.random_algorithm
  end

  def leetcode_problem(minimum_difficulty)
    @leetcode.random_problem(minimum_difficulty)
  end
end
