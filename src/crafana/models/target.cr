require "json"
require "../vars"

module Crafana
  class Target
    include JSON::Serializable

    property expr : String = ""

    @[JSON::Field(key: "format")]
    property target_format : String = Crafana::Vars::TIME_SERIES_TARGET_FORMAT

    @[JSON::Field(key: "legendFormat")]
    property legend_format : String = ""

    property interval : String = ""

    @[JSON::Field(key: "intervalFactor")]
    property interval_factor : Int32 = 2

    property metric : String = ""

    @[JSON::Field(key: "refId")]
    property ref_id : String = ""

    property step : Int32 = Crafana::Vars::DEFAULT_STEP

    property target : String = ""

    property instant : Bool = false

    property datasource : String = ""

    property hide : Bool = false

    def initialize(@expr, @target_format, @ref_id)
    end
  end
end
