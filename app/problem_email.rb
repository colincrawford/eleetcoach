module ProblemEmail
  class Email
    def initialize(problem)
      @problem = problem
    end

    def html
      <<~HTML
        Here is your Leetcode problem!
        <br>
        Difficulty: #{@problem.difficulty}
        <br>
        <a href=#{@problem.link}>#{@problem.title}</a>
      HTML
    end

    def text
      <<~TEXT
        Here is your Leetcode problem!
        Difficulty: #{@problem.difficulty}\n
        Title: #{@problem.title}\n
        #{@problem.link}
      TEXT
    end
  end

  class Factory
    def self.create(problem)
      ProblemEmail::Email.new(problem)
    end
  end
end
