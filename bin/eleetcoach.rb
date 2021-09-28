require "logger"
require "sinatra"

["app", "lib"].each do |dir|
  Dir[File.join(__dir__, "..", dir, "*.rb")].sort.each do |file|
    require file
  end
end

logger = Logger.new($stdout)

config = Config.new(logger: logger)

leetcode = Leetcode::Client.new(
  logger: logger,
  minimum_difficulty: config.minimum_difficulty
)
wikipedia_algorithms = Wikipedia::AlgorithmsPage.new
app = App.new(
  logger: logger,
  leetcode: leetcode,
  wikipedia_algorithms: wikipedia_algorithms,
)

# Web app (Sinatra) setup

def json(value)
  content_type :json
  value.to_json
end

get '/api/wikipedia-algorithm' do
  json(app.wikipedia_algorithm)
end

get '/api/leetcode-problem' do
  json(app.leetcode_problem)
end

not_found do
  content_type :json
  '{"msg": "Not Found", "code": 404}'
end
