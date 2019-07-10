require "json"

module Crafana
  class Gauge
    include JSON::Serializable

    @[JSON::Field(key: "maxValue")]
    property max_value : Int32 = 1

    @[JSON::Field(key: "minValue")]
    property min_value : Int32 = 0

    property show : Bool = false

    @[JSON::Field(key: "thresholdLabels")]
    property threshold_labels : Bool = false

    @[JSON::Field(key: "thresholdMarkers")]
    property threshold_markers : Bool = true

    def initialize(@max_value, @min_value, @show = false,
                   @threshold_labels = false, @threshold_markers = true)
    end
  end
end
