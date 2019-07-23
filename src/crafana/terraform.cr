require "./terraform/*"
require "./builder"

class Crafana::Terraform::Builder < Crafana::Builder
  alias DashInfo = NamedTuple(dash: Crafana::Dashboard,
    title: String, file_path: String, file_name: String)

  property user : String = "admin"
  property password : String = "admin"

  # Wite a terraform files to the *output_folder*
  private def write_terraform_files(output_folder)
    Dir.cd(output_folder) do
      # Write dashboards file
      File.open("dashboards.tf", "w+") do |file|
        dashboards.each do |dash|
          file.puts <<-END
          resource "grafana_dashboard" "#{dash[:title]}" {
            config_json = "${file("dashboards/#{dash[:file_name]}")}"
          }\n\n
          END
        end
      end

      defs = Array(String).new
      vars = Array(String).new

      self.datasources.each do |d|
        defs << d.to_tf
        vars << d.to_tf_vars
      end

      # Write datasources file
      File.open("data_sources.tf", "w+") do |file|
        defs.each { |v| file.puts(v) }
      end

      # Write secrets file
      File.open("secrets.tf", "w+") do |file|
        file << <<-END
        variable grafana_auth {
          type = string
          default = "#{self.user}:#{self.pass}"
        }\n\n
        END
        vars.each { |v| file.puts(v) }
      end
    end
  end

  # Write each entry in *dashboards* to a json file
  private def write_dashboard_files
    dashboards.each do |dash|
      logger.info("Writing dashboard: \"#{dash[:dash].title}\" to file: #{dash[:file_path]}", "CT::Metrics::Grafana")
      File.open(dash[:file_path], "w+") do |file|
        file.puts dash[:dash].to_pretty_json
      end
    end
  end
end
