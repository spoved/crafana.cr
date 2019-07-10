require "../spec_helper"

describe Crafana::Builder do
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
