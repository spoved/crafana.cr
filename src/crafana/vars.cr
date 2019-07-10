require "./models/rgba"
require "./models/time"
require "./models/mapping"

# Definition of various constants used as defaults
module Crafana::Vars
  GREY1     = Crafana::RGBA.new(216, 200, 27, 0.27)
  GREY2     = Crafana::RGBA.new(234, 112, 112, 0.22)
  BLUE_RGBA = Crafana::RGBA.new(31, 118, 189, 0.18)
  BLUE_RGB  = Crafana::RGB.new(31, 120, 193)
  GREEN     = Crafana::RGBA.new(115, 191, 105, 0.9)
  YELLOW    = Crafana::RGBA.new(250, 222, 42, 0.9)
  ORANGE    = Crafana::RGBA.new(237, 129, 40, 0.9)
  RED       = Crafana::RGBA.new(242, 73, 92, 0.9)
  BLANK     = Crafana::RGBA.new(0, 0, 0, 0.0)

  INDIVIDUAL = "individual"
  CUMULATIVE = "cumulative"

  NULL_CONNECTED = "connected"
  NULL_AS_ZERO   = "null as zero"
  NULL_AS_NULL   = "null"

  FLOT = "flot"

  ABSOLUTE_TYPE   = "absolute"
  DASHBOARD_TYPE  = "dashboard"
  GRAPH_TYPE      = "graph"
  SINGLESTAT_TYPE = "singlestat"
  TABLE_TYPE      = "table"
  TEXT_TYPE       = "text"
  ALERTLIST_TYPE  = "alertlist"
  ROW_TYPE        = "row"

  DEFAULT_FILL         = 1
  DEFAULT_REFRESH      = "10s"
  DEFAULT_ROW_HEIGHT   = Pixels.new(240)
  DEFAULT_LINE_WIDTH   = 2
  DEFAULT_POINT_RADIUS = 5
  DEFAULT_RENDERER     = FLOT
  DEFAULT_STEP         = 10
  DEFAULT_LIMIT        = 10
  TOTAL_SPAN           = 12

  DARK_STYLE  = "dark"
  LIGHT_STYLE = "light"

  UTC                 = "utc"
  DEFAULT_TIME        = Crafana::Time.new("now-1h", "now")
  DEFAULT_TIME_PICKER = TimePicker.new(
    refresh_intervals: [
      "5s",
      "10s",
      "30s",
      "1m",
      "5m",
      "15m",
      "30m",
      "1h",
      "2h",
      "1d",
    ],
    time_options: [
      "5m",
      "15m",
      "1h",
      "6h",
      "12h",
      "24h",
      "2d",
      "7d",
      "30d",
    ]
  )

  SCHEMA_VERSION = 1

  # Y Axis formats
  DURATION_FORMAT      = "dtdurations"
  NO_FORMAT            = "none"
  OPS_FORMAT           = "ops"
  PERCENT_UNIT_FORMAT  = "percentunit"
  DAYS_FORMAT          = "d"
  HOURS_FORMAT         = "h"
  MINUTES_FORMAT       = "m"
  SECONDS_FORMAT       = "s"
  MILLISECONDS_FORMAT  = "ms"
  SHORT_FORMAT         = "short"
  BYTES_FORMAT         = "bytes"
  BITS_PER_SEC_FORMAT  = "bps"
  BYTES_PER_SEC_FORMAT = "Bps"

  # Alert rule state
  STATE_NO_DATA         = "no_data"
  STATE_ALERTING        = "alerting"
  STATE_KEEP_LAST_STATE = "keep_state"

  # Evaluator
  EVAL_GT            = "gt"
  EVAL_LT            = "lt"
  EVAL_WITHIN_RANGE  = "within_range"
  EVAL_OUTSIDE_RANGE = "outside_range"
  EVAL_NO_VALUE      = "no_value"

  # Reducer Type
  # avg/min/max/sum/count/last/median/diff/percent_diff/count_non_null
  RTYPE_AVG            = "avg"
  RTYPE_MIN            = "min"
  RTYPE_MAX            = "max"
  RTYPE_SUM            = "sum"
  RTYPE_COUNT          = "count"
  RTYPE_LAST           = "last"
  RTYPE_MEDIAN         = "median"
  RTYPE_DIFF           = "diff"
  RTYPE_PERCENT_DIFF   = "percent_diff"
  RTYPE_COUNT_NON_NULL = "count_non_null"

  # Condition Type
  CTYPE_QUERY = "query"

  # Operator
  OP_AND = "and"
  OP_OR  = "or"

  # Text panel modes
  TEXT_MODE_MARKDOWN = "markdown"
  TEXT_MODE_HTML     = "html"
  TEXT_MODE_TEXT     = "text"

  # Datasource plugins
  PLUGIN_ID_GRAPHITE      = "graphite"
  PLUGIN_ID_PROMETHEUS    = "prometheus"
  PLUGIN_ID_INFLUXDB      = "influxdb"
  PLUGIN_ID_OPENTSDB      = "opentsdb"
  PLUGIN_ID_ELASTICSEARCH = "elasticsearch"
  PLUGIN_ID_CLOUDWATCH    = "cloudwatch"

  # Target formats
  TIME_SERIES_TARGET_FORMAT = "time_series"
  TABLE_TARGET_FORMAT       = "table"

  # Table Transforms
  AGGREGATIONS_TRANSFORM = "timeseries_aggregations"
  ANNOTATIONS_TRANSFORM  = "annotations"
  COLUMNS_TRANSFORM      = "timeseries_to_columns"
  JSON_TRANSFORM         = "json"
  ROWS_TRANSFORM         = "timeseries_to_rows"
  TABLE_TRANSFORM        = "table"

  # AlertList show selections
  ALERTLIST_SHOW_CURRENT = "current"
  ALERTLIST_SHOW_CHANGES = "changes"

  # AlertList state filter options
  ALERTLIST_STATE_OK              = "ok"
  ALERTLIST_STATE_PAUSED          = "paused"
  ALERTLIST_STATE_NO_DATA         = "no_data"
  ALERTLIST_STATE_EXECUTION_ERROR = "execution_error"
  ALERTLIST_STATE_ALERTING        = "alerting"

  # Display Sort Order
  SORT_ASC        = 1
  SORT_DESC       = 2
  SORT_IMPORTANCE = 3

  # Template
  REFRESH_NEVER                = 0
  REFRESH_ON_DASHBOARD_LOAD    = 1
  REFRESH_ON_TIME_RANGE_CHANGE = 2
  SHOW                         = 0
  HIDE_LABEL                   = 1
  HIDE_VARIABLE                = 2
  SORT_DISABLED                = 0
  SORT_ALPHA_ASC               = 1
  SORT_ALPHA_DESC              = 2
  SORT_NUMERIC_ASC             = 3
  SORT_NUMERIC_DESC            = 4
  SORT_ALPHA_IGNORE_CASE_ASC   = 5
  SORT_ALPHA_IGNORE_CASE_DESC  = 6

  MAPPING_TYPE_VALUE_TO_TEXT = 1
  MAPPING_TYPE_RANGE_TO_TEXT = 2

  MAPPING_VALUE_TO_TEXT = Crafana::Mapping.new("value to text", MAPPING_TYPE_VALUE_TO_TEXT)
  MAPPING_RANGE_TO_TEXT = Crafana::Mapping.new("range to text", MAPPING_TYPE_RANGE_TO_TEXT)

  # Value types min/max/avg/current/total/name/first/delta/range
  VTYPE_MIN     = "min"
  VTYPE_MAX     = "max"
  VTYPE_AVG     = "avg"
  VTYPE_CURR    = "current"
  VTYPE_TOTAL   = "total"
  VTYPE_NAME    = "name"
  VTYPE_FIRST   = "first"
  VTYPE_DELTA   = "delta"
  VTYPE_RANGE   = "range"
  VTYPE_DEFAULT = VTYPE_AVG
end
