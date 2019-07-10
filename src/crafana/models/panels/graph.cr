require "json"
require "../panel"

module Crafana
  # Generates Graph panel json structure.
  #   :param dataSource: DataSource's name
  #   :param minSpan: Minimum width for each panel
  #   :param repeat: Template's name to repeat Graph on
  class Graph < Crafana::Panel
    include JSON::Serializable
    include TargetList

    @[JSON::Field(key: "aliasColors")]
    property alias_colors : AliasColors? = nil

    property bars : Bool = false

    @[JSON::Field(key: "dashLength")]
    property dash_length : Int32 = 10

    property dashes : Bool?

    property datasource : String?

    property fill : Int32 = 1

    @[JSON::Field(key: "gridPos")]
    property grid_pos : GridPos

    @[JSON::Field(key: "isNew")]
    property is_new = true

    property legend : Crafana::Legend = Crafana::Legend.new

    property lines : Bool = true

    property linewidth : Int32 = Crafana::Vars::DEFAULT_LINE_WIDTH

    property links : Array(JSON::Any) = Array(JSON::Any).new

    @[JSON::Field(key: "maxPerRow")]
    property max_per_row : Int32 = 6

    @[JSON::Field(key: "nullPointMode")]
    property null_point_mode : String = Crafana::Vars::NULL_CONNECTED

    property options : JSON::Any?
    property percentage : Bool = false

    @[JSON::Field(key: "paceLength")]
    property pace_length : Int32?

    property pointradius : Int32 = Crafana::Vars::DEFAULT_POINT_RADIUS

    property points : Bool = false

    property renderer : String = Crafana::Vars::DEFAULT_RENDERER

    @[JSON::Field(key: "seriesOverrides")]
    property series_overrides = Array(JSON::Any).new

    @[JSON::Field(key: "spaceLength")]
    property space_length : Int32 = 10

    property stack : Bool = false

    @[JSON::Field(key: "steppedLine")]
    property stepped_line : Bool = false
    property thresholds : Array(Threshold)?

    @[JSON::Field(key: "timeFrom")]
    property time_from : String?

    @[JSON::Field(key: "timeRegions")]
    property time_regions : Array(JSON::Any) = Array(JSON::Any).new

    @[JSON::Field(key: "timeShift")]
    property time_shift : String?

    property tooltip : Tooltip?

    property xaxis : XAxis = Crafana::XAxis.new
    property yaxes : YAxes = Crafana::YAxes.new

    def initialize(@datasource, @dashboard : Crafana::Dashboard? = nil, @title = "")
      @panel_type = Crafana::Vars::GRAPH_TYPE
      @id = @dashboard.as(Crafana::Dashboard).next_panel_id unless @dashboard.nil?
    end
  end
end
