class App
  def initialize(logger:, leetcode:, mailer:, problem_email_factory:, send_list:)
    @logger = logger
    @leetcode = leetcode
    @mailer = mailer
    @problem_email_factory = problem_email_factory
    @send_list = send_list
  end

  def run
    send_problem(@leetcode.random_problem)
  end

  private

  def send_problem(problem)
    email = @problem_email_factory.create(problem)
    @send_list.each { |to| send_email(to, email) }
  end

  def send_email(to, email)
    @logger.info { "Sending problem to #{to}" }
    @mailer.send_html(
      to: to,
      from: "Eleetcoach <eleetcoach@gmail.com>",
      subject: "Daily Leetcode Problem",
      message: email.html
    )
  end
end
