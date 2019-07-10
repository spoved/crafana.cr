require "../spec_helper"

describe Crafana::Api do
  it "should create client" do
    client.should be_a(Spoved::Api::Client)
    client.should be_a(Crafana::Api::Client)
  end
end
