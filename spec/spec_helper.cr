require "dotenv"
Dotenv.load if File.exists?(".env")

ENV["CRYSTAL_ENV"] = "test"
if ENV["GRAFANA_URL"]?.nil?
  ENV["GRAFANA_URL"] ||= "http://localhost"
  ENV["GRAFANA_USERNAME"] ||= "admin"
  ENV["GRAFANA_PASSWORD"] ||= "password"
  ENV["GRAFANA_TOKEN"] ||= "abcd1234"
end

require "vcr"
require "spec"
require "../src/crafana"

GRAFANA_CLIENT = Crafana::Api.client

def client
  GRAFANA_CLIENT
end

VCR.configure do |settings|
  settings.filter_sensitive_data["api_key"] = ENV["GRAFANA_TOKEN"]
end

Spec.before_suite {
  # spoved_logger :trace, bind: true
  load_cassette("grafana")
}
