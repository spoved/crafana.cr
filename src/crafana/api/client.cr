require "spoved/api/client"
require "../models/*"

class Crafana::Api::Client < Spoved::Api::Client
  def initialize(@host : String,
                 @port : Int32? = nil,
                 @scheme = "https",
                 args : NamedTuple? = nil)
    if args[:token]?
      @default_headers = {
        "Content-Type"  => "application/json",
        "Accept"        => "application/json",
        "Authorization" => "Bearer #{args[:token]?}",
      }
    else
      @user = args[:user]?
      @pass = args[:pass]?
    end

    @api_path = "api"
  end

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
