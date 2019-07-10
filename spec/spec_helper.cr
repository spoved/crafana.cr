require "dotenv"
Dotenv.load

ENV["CRYSTAL_ENV"] = "test"
ENV["GRAFANA_URL"] = "" unless ENV["GRAFANA_URL"]?

require "vcr"
require "http/client"

require "spec"
require "../src/crafana"

GRAFANA_CLIENT = Crafana::Api.client

def client
  GRAFANA_CLIENT
end
