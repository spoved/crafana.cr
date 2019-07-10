require "json"
require "../panel"
require "../percent"
require "../column"

module Crafana
  # Generates Table panel json structure
  #   Grafana doc on table: http://docs.grafana.org/reference/table_panel/
  #   :param columns: table columns for Aggregations view
  #   :param dataSource: Grafana datasource name
  #   :param description: optional panel description
  #   :param editable: defines if panel is editable via web interfaces
  #   :param fontSize: defines value font size
  #   :param height: defines panel height
  #   :param hideTimeOverride: hides time overrides
  #   :param id: panel id
  #   :param links: additional web links
  #   :param minSpan: minimum span number
  #   :param pageSize: rows per page (None is unlimited)
  #   :param scroll: scroll the table instead of displaying in full
  #   :param showHeader: show the table header
  #   :param span: defines the number of spans that will be used for panel
  #   :param styles: defines formatting for each column
  #   :param targets: list of metric requests for chosen datasource
  #   :param timeFrom: time range that Override relative time
  #   :param title: panel title
  #   :param transform: table style
  #   :param transparent: defines if panel should be transparent
  class Table < Crafana::Panel
    include JSON::Serializable
    include TargetList

    property datasource : String
    property columns : Array(Crafana::Column) = Array(Crafana::Column).new
    @[JSON::Field(key: "fontSize")]
    property font_size : Crafana::Percent = Crafana::Percent.new(100)
    @[JSON::Field(key: "hideTimeOverride")]
    property hide_time_override = false
    property links : Array(JSON::Any) = Array(JSON::Any).new
    @[JSON::Field(key: "minSpan")]
    property min_span : String?
    @[JSON::Field(key: "pageSize")]
    property page_size : Int32?

    property scroll : Bool = true

    @[JSON::Field(key: "showHeader")]
    property show_header : Bool = true

    property span = 6

    property sort : Crafana::ColumnSort = Crafana::ColumnSort.new

    property styles : String?

    @[JSON::Field(key: "timeFrom")]
    property time_from : String?

    property transform = Crafana::Vars::COLUMNS_TRANSFORM

    def self.styles_default : Array(Crafana::ColumnStyle)
      Array(Crafana::ColumnStyle).new(
        Crafana::ColumnStyle::Date.new(
          alias: "Time",
          pattern: "time",
        ),
        Crafana::ColumnStyle.new(
          pattern: "/.*/",
        ))
    end

    def initialize(@dashboard : Crafana::Dashboard, @datasource)
      @panel_type = TABLE_TYPE
      @id = @dashboard.next_panel_id
    end
  end
end
