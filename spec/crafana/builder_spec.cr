require "../spec_helper"

describe Crafana::Builder do
  describe "dashboards" do
    it "can create a new dashboard" do
      Crafana::Builder.new do |builder|
        builder.add_dashboard("My new dash") # => #<Crafana::Dashboard:0x108a01dc0>
        dash = builder.add_dashboard("My new dash")
        dash.should be_a Crafana::Dashboard
        dash.title.should eq "My new dash"
      end
    end

    it "yeilds dashboard to the block" do
      builder = Crafana::Builder.build do |b|
        b.add_dashboard("My new dash") do |dash|
          dash.should be_a Crafana::Dashboard
          dash.title.should eq "My new dash"
        end
      end

      builder.should be_a Crafana::Builder
      builder.dashboards[0].title.should eq "My new dash"
    end

    it "should be able to generate a dashboard" do
      Crafana::Builder.build do |b|
        b.add_dashboard(title: "Elasticsearch Test") do |dash|
          dash.should be_a Crafana::Dashboard
          dash.panels.size.should eq 0

          dash.add_row do |row|
            dash.panels.size.should eq 1

            row.title = "Production Test"
            row.add_graph(datasource: "datasource 1") do |graph|
              graph.should be_a(Crafana::Graph)
              graph.datasource.should eq "datasource 1"
            end
          end

          dash.panels.size.should eq 2
          dash.panels.first.grid_pos.h.should eq 8
        end
      end
    end
  end

  describe "folders" do
    it "can create a new folder" do
      builder = Crafana::Builder.new
      folder = builder.add_folder("My Folder")
      folder.should be_a(Crafana::Folder)
      builder.folders.should_not be_empty
      builder.folders.first.should eq folder
    end

    it "yeilds folder to the block" do
      builder = Crafana::Builder.new
      builder.add_folder("My Folder") do |folder|
        folder.should be_a(Crafana::Folder)
      end
      builder.folders.should_not be_empty
      builder.folders.first.should be_a(Crafana::Folder)
    end

    it "accepts a pre-created folder" do
      folder = Crafana::Folder.new("My Folder")
      builder = Crafana::Builder.new
      builder.add_folder folder
      builder.folders.should_not be_empty
      builder.folders.first.should eq folder
    end
  end

  describe "datasources" do
    it "can create a new datasource" do
      builder = Crafana::Builder.new
      datasource = builder.add_datasource("My DataSource", "prometheus")
      datasource.should be_a(Crafana::DataSource)
      builder.datasources.should_not be_empty
      builder.datasources.first.should eq datasource
    end

    it "yeilds datasource to the block" do
      builder = Crafana::Builder.new
      builder.add_datasource("My DataSource", "prometheus") do |datasource|
        datasource.should be_a(Crafana::DataSource)
      end
      builder.datasources.should_not be_empty
      builder.datasources.first.should be_a(Crafana::DataSource)
    end

    it "accepts a pre-created datasource" do
      datasource = Crafana::DataSource.new("My DataSource", "prometheus")
      builder = Crafana::Builder.new
      builder.add_datasource datasource
      builder.datasources.should_not be_empty
      builder.datasources.first.should eq datasource
    end
  end
end
