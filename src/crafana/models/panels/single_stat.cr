require "json"
require "../../vars"
require "../percent"
require "../range_map"
require "../sparkline"
require "../panel"

module Crafana
  # Generates Single Stat panel json structure
  #
  # Grafana doc on singlestat: [http://docs.grafana.org/reference/singlestat/](http://docs.grafana.org/reference/singlestat/)
  #
  #   `#data_source` Grafana datasource name
  #
  #   `#targets` list of metric requests for chosen datasource
  #
  #   `#title` panel title
  #
  #   `#cache_timeout` metric query result cache ttl
  #
  #   `#colors` the list of colors that can be used for coloring
  #    panel value or background. Additional info on coloring in docs:
  #    [http://docs.grafana.org/reference/singlestat/#coloring](http://docs.grafana.org/reference/singlestat/#coloring)
  #
  #   `#color_background` defines if grafana will color panel background
  #
  #   `#color_value` defines if grafana will color panel value
  #
  #   `#description` optional panel description
  #
  #   `#decimals` override automatic decimal precision for legend/tooltips
  #
  #   `#editable` defines if panel is editable via web interfaces
  #
  #   `#format` defines value units
  #
  #   `#gauge` draws and additional speedometer-like gauge based
  #
  #   `#height` defines panel height
  #
  #   `#hide_time_override` hides time overrides
  #
  #   `#id` panel id
  #
  #   `#interval` defines time interval between metric queries
  #
  #   `#links` additional web links
  #
  #   `#mapping_type` defines panel mapping type.
  #    Additional info can be found in docs:
  #    [http://docs.grafana.org/reference/singlestat/#value-to-text-mapping](http://docs.grafana.org/reference/singlestat/#value-to-text-mapping)
  #
  #   `#mapping_types` the list of available mapping types for panel
  #
  #   `#max_data_points` maximum metric query results,
  #    that will be used for rendering
  #
  #   `#minSpan` minimum span number
  #
  #   `#nullText` defines what to show if metric query result is undefined
  #
  #   `#nullPointMode` defines how to render undefined values
  #
  #   `#postfix` defines postfix that will be attached to value
  #
  #   `#postfixFontSize` defines postfix font size
  #
  #   `#prefix` defines prefix that will be attached to value
  #
  #   `#prefixFontSize` defines prefix font size
  #
  #   `#rangeMaps` the list of value to text mappings
  #
  #   `#span` defines the number of spans that will be used for panel
  #
  #   `#sparkline` defines if grafana should draw an additional sparkline.
  #   Sparkline grafana documentation:
  #   [http://docs.grafana.org/reference/singlestat/#spark-lines](http://docs.grafana.org/reference/singlestat/#spark-lines)
  #
  #   `#thresholds` single stat thresholds
  #
  #   `#transparent` defines if panel should be transparent
  #
  #   `#valueFontSize` defines value font size
  #
  #   `#valueName` defines value type. possible values are:
  #   min, max, avg, current, total, name, first, delta, range
  #
  #   `#valueMaps` the list of value to text mappings
  #
  #   `#timeFrom` time range that Override relative time
  class SingleStat < Crafana::Panel
    include JSON::Serializable
    include TargetList

    property datasource : String
    @[JSON::Field(key: "cacheTimeout")]
    property cache_timeout : Int32?
    property colors : Array(RGBA) = [
      Crafana::Vars::GREEN,
      Crafana::Vars::ORANGE,
      Crafana::Vars::RED,
    ]

    @[JSON::Field(key: "colorBackground")]
    property color_background : Bool = false

    @[JSON::Field(key: "colorValue")]
    property color_value : Bool = false

    @[JSON::Field(key: "format")]
    property panel_format : String = "none"
    property gauge : Gauge?
    property interval : String = ""
    property links : Array(JSON::Any) = Array(JSON::Any).new
    @[JSON::Field(key: "mappingType")]
    property mapping_type : Int32 = Crafana::Vars::MAPPING_TYPE_VALUE_TO_TEXT

    @[JSON::Field(key: "mappingTypes")]
    property mapping_types : Array(Mapping) = [
      Crafana::Vars::MAPPING_VALUE_TO_TEXT,
      Crafana::Vars::MAPPING_RANGE_TO_TEXT,
    ]

    @[JSON::Field(key: "maxDataPoints")]
    property max_data_points : Int32 = 100

    @[JSON::Field(key: "nullPointMode")]
    property null_point_mode : String = Crafana::Vars::NULL_CONNECTED

    @[JSON::Field(key: "nullText")]
    property null_text : String?
    property options : JSON::Any?
    property postfix : String = ""
    @[JSON::Field(key: "postfixFontSize")]
    property postfix_font_size : Crafana::Percent = Crafana::Percent.new(50)

    property prefix : String = ""

    @[JSON::Field(key: "prefixFontSize")]
    property prefix_font_size : Crafana::Percent = Crafana::Percent.new(50)
    @[JSON::Field(key: "rangeMaps")]
    property range_maps : Array(Crafana::RangeMap) = Array(Crafana::RangeMap).new
    property sparkline : Crafana::Sparkline = Crafana::Sparkline.new
    @[JSON::Field(key: "tableColumn")]
    property table_column : String?
    property thresholds : String = ""
    @[JSON::Field(key: "valueFontSize")]
    property value_font_size : Crafana::Percent = Crafana::Percent.new(50)

    @[JSON::Field(key: "valueMaps")]
    property value_maps : Array(Crafana::ValueMap)?

    @[JSON::Field(key: "valueName")]
    property value_name : String = Crafana::Vars::VTYPE_DEFAULT

    @[JSON::Field(key: "timeFrom")]
    property time_from : String?
    getter panel_type : String = Crafana::Vars::SINGLESTAT_TYPE

    def initialize(@datasource : String, @dashboard : Crafana::Dashboard? = nil)
      @panel_type = Crafana::Vars::SINGLESTAT_TYPE
      @id = @dashboard.as(Crafana::Dashboard).next_panel_id unless @dashboard.nil?
    end
  end
end
