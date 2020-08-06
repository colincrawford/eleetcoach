class App
  def initialize(logger:, leetcode:, mailer:, problem_email_factory:, send_list:)
    @logger = logger
    @leetcode = leetcode
    @mailer = mailer
    @problem_email_factory = problem_email_factory
    @send_list = send_list
  end

  def run
    problem = @leetcode.random_problem
    email = @problem_email_factory.create(problem)
    @send_list.each do | to |
      @mailer.send_html(to, "Daily Leetcode Problem", email.html)
    end
  end
end
