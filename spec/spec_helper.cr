require "dotenv"
Dotenv.load

ENV["CRYSTAL_ENV"] = "test"
ENV["GRAFANA_URL"] ||= "http://localhost"
ENV["GRAFANA_USERNAME"] ||= "admin"
ENV["GRAFANA_PASSWORD"] ||= "password"
ENV["GRAFANA_TOKEN"] ||= "abcd1234"

require "vcr"
require "http/client"

require "spec"
require "../src/crafana"

GRAFANA_CLIENT = Crafana::Api.client

def client
  GRAFANA_CLIENT
end
