require "json"

module Crafana
  class Threshold
    include JSON::Serializable

    @[JSON::Field(key: "colorMode")]
    property color_mode : String

    property fill : Bool

    property line : Bool

    property op : String

    property yaxis : String
  end
end
