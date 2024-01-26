require "./api/*"

module Crafana::Api
  def self.client : Client
    if ENV["GRAFANA_USERNAME"]? && ENV["GRAFANA_PASSWORD"]?
      Client.new(URI.parse(ENV["GRAFANA_URL"]), api_path: "api", user: ENV["GRAFANA_USERNAME"], pass: ENV["GRAFANA_PASSWORD"])
    else
      Client.new(URI.parse(ENV["GRAFANA_URL"]), api_path: "api", default_headers: {
        "Content-Type"  => "application/json",
        "Accept"        => "application/json",
        "Authorization" => "Bearer #{ENV["GRAFANA_TOKEN"]}",
      })
    end
  end
end
