require "./api/*"

module Crafana::Api
  def self.client : Client
    if ENV["GRAFANA_USERNAME"]? && ENV["GRAFANA_PASSWORD"]?
      Client.new(URI.parse(ENV["GRAFANA_URL"]), user: ENV["GRAFANA_USERNAME"], pass: ENV["GRAFANA_PASSWORD"])
    else
      Client.new(URI.parse(ENV["GRAFANA_URL"]), token: ENV["GRAFANA_TOKEN"])
    end
  end
end
