require "json"
require "./y_axis"
require "../vars"

module Crafana
  # The pair of Y axes on a Grafana graph.
  # Each graph has two Y Axes, a left one and a right one.
  class YAxes
    property left : YAxis = YAxis.new(axis_format: Crafana::Vars::SHORT_FORMAT)
    property right : YAxis = YAxis.new(axis_format: Crafana::Vars::SHORT_FORMAT)

    def self.new(pull : JSON::PullParser)
      _yaxes = YAxes.new
      pull.read_array do
        _yaxes.left = YAxis.new(pull)
        _yaxes.right = YAxis.new(pull)
      end
      _yaxes
    end

    def to_json(json : ::JSON::Builder)
      json.array do
        left.to_json(json)
        right.to_json(json)
      end
    end

    def initialize(@left = YAxis.new(axis_format: Crafana::Vars::SHORT_FORMAT),
                   @right = YAxis.new(axis_format: Crafana::Vars::SHORT_FORMAT))
    end
  end
end
