require "json"

module Crafana
  # A single Y axis.
  # Grafana graphs have two Y axes: one on the left and one on the right.
  class YAxis
    # :nodoc:
    class IntConverter
      def self.from_json(pull : JSON::PullParser)
        case pull.kind
        when :string
          pull.read_string.to_i
        else
          raise "Unsupported conversion for kind: #{pull.kind}"
        end
      end

      def self.to_json(value, builder : JSON::Builder)
        builder.number(value)
      end
    end

    include JSON::Serializable

    property decimals : String? = nil

    @[JSON::Field(key: "format")]
    property axis_format : String? = nil

    property label : String? = nil

    @[JSON::Field(key: "logBase")]
    property log_base : Int32 = 1

    @[JSON::Field(converter: Crafana::YAxis::IntConverter)]
    property max : Int32? = nil

    @[JSON::Field(converter: Crafana::YAxis::IntConverter)]
    property min : Int32? = 0

    property show : Bool = true

    property align : Bool? = nil

    @[JSON::Field(key: "alignLevel")]
    property align_level : String? = nil

    def initialize(@axis_format = SHORT_FORMAT, @label = nil,
                   @log_base = 1, @max = nil, @min = 0, @show = true)
    end
  end
end
