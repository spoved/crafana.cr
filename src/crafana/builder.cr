require "./vars"
require "./models/*"

# A builder to help generate Grafana datasources and dashboards easily
#
# ```
# builder = Crafana::Builder.new
# builder.add_dashboard("My new dash") do |dash|
#   # Add sub panels to the dashboard here
#
#   dash.add_row("row 1") do |row|
#     # Configure row here
#   end
#
#   dash.add_graph("graph 1") do |graph|
#     # Configure graph here
#   end
# end
# ```
class Crafana::Builder
  getter datasources : Array(Crafana::DataSource) = Array(Crafana::DataSource).new
  getter dashboards : Array(Crafana::Dashboard) = Array(Crafana::Dashboard).new
  getter folders : Array(Crafana::Folder) = Array(Crafana::Folder).new

  # Create a new *Crafana::Builder* instance
  #
  # ```
  # builder = Crafana::Builder.new
  # ```
  def initialize
  end

  # Create a new *Crafana::Builder* instance and yield it to block
  #
  # ```
  # builder = Crafana::Builder.new do |builder|
  #   # Build your dashboards here
  # end
  # ```
  def self.new(&block : Crafana::Builder ->) : Crafana::Builder
    builder = Crafana::Builder.new
    yield builder
    builder
  end

  # Create a new *Crafana::Builder* instance and yield it to block
  #
  # ```
  # builder = Crafana::Builder.build do |builder|
  #   # Build your dashboards here
  # end
  # ```
  def self.build(&block : Crafana::Builder ->) : Crafana::Builder
    builder = Crafana::Builder.new
    yield builder
    builder
  end

  ######################
  # folders
  ######################

  # Add a folder
  #
  # ```
  # folder = Crafana::Folder.new("My Folder")
  # builder.add_folder(folder)
  # ```
  def add_folder(folder : Crafana::Folder) : Crafana::Folder
    self.folders << folder
    folder
  end

  # Add a folder
  #
  # ```
  # folder = builder.add_folder("My Folder")
  # ```
  def add_folder(title : String) : Crafana::Folder
    folder = Crafana::Folder.new(title)
    add_folder(folder)
  end

  # Add a folder
  #
  # ```
  # builder.add_folder("My Folder") do |folder|
  #   folder.can_edit = false
  # end
  # ```
  def add_folder(title : String, &block : Crafana::Folder ->) : Crafana::Folder
    folder = Crafana::DataSource.new(title)
    add_folder(folder)
    yield folder
    folder
  end

  ######################
  # datasources
  ######################

  # Add a datasource
  #
  # ```
  # datasource = Crafana::DataSource.new("My Datasource")
  # builder.add_datasource(datasource)
  # ```
  def add_datasource(datasource : Crafana::DataSource) : Crafana::DataSource
    self.datasources << datasource
    datasource
  end

  # Add a datasource
  #
  # ```
  # datasource = builder.add_datasource("My Datasource")
  # ```
  def add_datasource(title : String) : Crafana::DataSource
    datasource = Crafana::DataSource.new(title)
    add_datasource(datasource)
  end

  # Add a datasource
  #
  # ```
  # builder.add_datasource("My Datasource") do |datasource|
  #   datasource.database = "my_database"
  # end
  # ```
  def add_datasource(title : String, &block : Crafana::DataSource ->) : Crafana::DataSource
    datasource = Crafana::DataSource.new(title)
    add_datasource(datasource)
    yield datasource
    datasource
  end

  ######################
  # dashboards
  ######################

  # Add a dashboard
  #
  # ```
  # builder = Crafana::Builder.new do |builder|
  #   builder.add_dashboard("My new dash") # => #<Crafana::Dashboard:0x108a01dc0>
  # end
  # ```
  def add_dashboard(title : String) : Crafana::Dashboard
    dash = Crafana::Dashboard.new(title: title)
    self.dashboards << dash
    dash
  end

  # Add a dashboard and yield it to the block
  #
  # ```
  # builder = Crafana::Builder.new
  # builder.add_dashboard("My new dash") do |dash|
  #   # do something with dashboards
  # end
  # ```
  def add_dashboard(title : String, &block : Crafana::Dashboard ->) : Crafana::Dashboard
    dash = Crafana::Dashboard.new(title: title)
    self.dashboards << dash
    yield dash
    dash
  end

  # Add a pre-created dashboard
  #
  # ```
  # builder = Crafana::Builder.new
  # dash = Crafana::Dashboard.new("My new dashboard")
  # builder.add_dashboard(dash)
  # ```
  def add_dashboard(dashboard : Crafana::Dashboard) : Crafana::Dashboard
    self.dashboards << dashboard
    dashboard
  end
end
