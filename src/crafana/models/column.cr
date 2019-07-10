require "json"
require "../vars"

module Crafana
  # Details of an aggregation column in a table panel.
  #   :param text: name of column
  #   :param value: aggregation function
  class Column
    include JSON::Serializable
    property text : String = "Avg"
    property value : String = "avg"
  end

  class ColumnSort
    include JSON::Serializable
    property col : String? = nil
    property desc = false

    def initialize(@col = nil, @desc = false)
    end
  end

  class ColumnStyle
    include JSON::Serializable

    @[JSON::Field(key: "alias")]
    property column_alias = ""

    property pattern = ""

    @[JSON::Field(key: "type")]
    getter column_style_type : ColumnStyleType
  end

  abstract class ColumnStyleType
    abstract def column_style_type : String

    class Date < ColumnStyleType
      include JSON::Serializable

      @[JSON::Field(key: "type")]
      getter column_style_type : String = "date"

      @[JSON::Field(key: "dateFormat")]
      property date_format = "YYYY-MM-DD HH:mm:ss"
    end

    class Number < ColumnStyleType
      include JSON::Serializable

      @[JSON::Field(key: "type")]
      getter column_style_type : String = "number"

      @[JSON::Field(key: "colorMode")]
      property color_mode : String?

      property colors : Array(Crafana::RGBA) = [
        Crafana::Vars::GREEN,
        Crafana::Vars::ORANGE,
        Crafana::Vars::RED,
      ]

      property thresholds : Array(String)?

      property decimals = 2

      property unit = Crafana::Vars::SHORT_FORMAT
    end

    class StringType < ColumnStyleType
      include JSON::Serializable

      @[JSON::Field(key: "type")]
      getter column_style_type : String = "string"

      @[JSON::Field(key: "preserveFormat")]
      getter preserve_format : Bool

      getter sanitize : Bool
    end

    class Hidden < ColumnStyleType
      include JSON::Serializable

      @[JSON::Field(key: "type")]
      getter column_style_type : String = "hidden"
    end
  end
end
