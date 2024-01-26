require "spoved/api/client"
require "../models/*"

class Crafana::Api::Client < Spoved::Api::Client
  def search(params)
    Array(Result).from_json self.get_raw("search", params).body
  end

  def users
    Array(User).from_json(self.get_raw("org/users").body)
  end

  def folders
    self.search({"type" => "dash-folder"})
  end

  def dashboards
    self.search({"type" => "dash-db"})
  end

  def dashboard(uid : String)
    self.get("dashboards/uid/#{uid}")
  end

  def dashboard_versions(id)
    self.get("dashboards/id/#{id}/versions")
  end

  def datasources
    Array(DataSource).from_json(self.get_raw("datasources").body)
  end

  def org
    Org.from_json(self.get_raw("org").body)
  end
end
