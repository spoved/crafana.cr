require "../../spec_helper"

describe Crafana::Dashboard do
  it "should deserialize the from json" do
    dash = Crafana::Dashboard.from_json(File.read("spec/files/dashboard.json"))
    dash.should_not be_nil
    dash.should be_a(Crafana::Dashboard)
  end
end
