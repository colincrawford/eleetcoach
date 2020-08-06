module ProblemEmail
  class Email
    def initialize(problem)
      @problem = problem
    end

    def html
      <<~HTML
        Here is your daily Leetcode problem!
        <br>
        Difficulty: #{@problem.difficulty}
        <br>
        <a href=#{@problem.link}>#{@problem.title}</a>
      HTML
    end
  end

  class Factory
    def self.create(problem)
      ProblemEmail::Email.new(problem)
    end
  end
end
