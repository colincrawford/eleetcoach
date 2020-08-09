require "logger"

Dir[File.join(__dir__, '..', 'app', '*.rb')].each { |file| require file }

logger = Logger.new(STDOUT)

config = nil
config_file_flag_inx = ARGV.find_index("--config")

if !config_file_flag_inx.nil?
  config_file = ARGV[config_file_flag_inx + 1]
  config = Config.new(logger: logger, config_file: config_file)
else
  config = Config.new(logger: logger)
end

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

