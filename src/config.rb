require "json"

class Config
  def initialize(logger:, config_file: "config.json")
    @logger = logger

    if File.file?(config_file)
      begin
        @config = JSON.parse(File.read(config_file), symbolize_names: true)
        @logger.debug("parsed file #{config_file}")
      rescue => err
        @logger.error("Failed to parse config file")
        raise "Cannot Parse Config"
      end
    else
      @logger.error("No config file found")
      raise "No Config File"
    end
  end

  def send_list
    @config[:send_list]
  end

  def gmail_email
    @config[:gmail_email]
  end

  def gmail_password
    @config[:gmail_password]
  end
end
