require "json"

module Crafana
  class Legend
    include JSON::Serializable

    property avg : Bool = false

    property current : Bool = false

    property max : Bool = false

    property min : Bool = false

    property show : Bool = true

    property total : Bool = false

    property values : Bool? = nil

    @[JSON::Field(key: "alignAsTable")]
    property align_as_table : Bool = false

    @[JSON::Field(key: "hideEmpty")]
    property hide_empty : Bool = false

    @[JSON::Field(key: "hideZero")]
    property hide_zero : Bool = false

    @[JSON::Field(key: "rightSide")]
    property right_side : Bool = false

    @[JSON::Field(key: "sideWidth")]
    property side_width : Nil = nil

    property sort : Nil = nil

    @[JSON::Field(key: "sortDesc")]
    property sort_sesc : Bool = false

    def initialize(@show = true, @max = false, @min = false, @avg = false,
                   @total = false, @values = nil, @align_as_table = false,
                   @hide_empty = false, @right_side = false, @side_width = nil,
                   @sort = nil, @sort_sesc = false)
    end
  end
end
