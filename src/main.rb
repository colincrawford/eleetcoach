require "logger"

require_relative "config.rb"
require_relative "leetcode.rb"
require_relative "gmail.rb"
require_relative "problem_email.rb"
require_relative "app.rb"

logger = Logger.new(STDOUT)

config = Config.new(logger: logger)
leetcode = Leetcode::Client.new(logger: logger)
mailer = GMail.new(
  logger: logger,
  email: config.gmail_email,
  password: config.gmail_password
)
app = App.new(
  logger: logger,
  leetcode: leetcode,
  mailer: mailer,
  problem_email_factory: ProblemEmail::Factory,
  send_list: config.send_list
)

app.run

