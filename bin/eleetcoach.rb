require "logger"

Dir[File.join(__dir__, '..', 'app', '*.rb')].each { |file| require file }

logger = Logger.new(STDOUT)

config_file_flag_inx = ARGV.find_index("--config")
config_file = nil
unless config_file_flag_inx.nil?
  config_file = ARGV[config_file_flag_inx + 1]
end
config = Config.new(logger: logger, config_file: config_file)

leetcode = Leetcode::Client.new(logger: logger)
mailer = GMail.new(
  logger: logger,
  email: config.gmail_email,
  password: config.gmail_password
)
app = App.new(
  logger: logger,
  minimum_difficulty: config.minimum_difficulty,
  leetcode: leetcode,
  mailer: mailer,
  problem_email_factory: ProblemEmail::Factory,
  send_list: config.send_list
)

app.run

