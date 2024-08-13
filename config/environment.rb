# Load the Rails application.
require_relative "application"

Rails.application.configure do
  config.time_zone = "UTC"
  config.active_record.default_timezone = :utc
end

# Initialize the Rails application.
Rails.application.initialize!
