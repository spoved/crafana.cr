require "json"
require "../vars"

module Crafana
  class Sparkline
    include JSON::Serializable

    @[JSON::Field(key: "fillColor")]
    property fill_color = Crafana::Vars::BLUE_RGBA

    property full : Bool = false

    @[JSON::Field(key: "lineColor")]
    property line_color : RGB = Crafana::Vars::BLUE_RGB

    property show : Bool = false

    def initialize
    end
  end
end
