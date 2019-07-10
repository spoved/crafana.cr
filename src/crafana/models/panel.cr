require "json"
require "../vars"
require "./grid_pos"
require "./target"
require "../modules/*"

module Crafana
  class Panel
    include JSON::Serializable

    property id : Int32?

    @[JSON::Field(key: "gridPos")]
    property grid_pos : Crafana::GridPos = Crafana::GridPos.new(0, 0, 0, 0)

    property title : String = ""
    property description : String?
    property repeat : String?

    @[JSON::Field(key: "repeatDirection")]
    property repeat_direction : String = "h"
    property editable : Bool = true
    property error : Bool = false
    property transparent : Bool = false

    @[JSON::Field(ignore: true)]
    property dashboard : Crafana::Dashboard? = nil

    @[JSON::Field(key: "type")]
    getter panel_type : String

    def dashboard : Crafana::Dashboard?
      @dashboard
    end

    def self.new(pull : JSON::PullParser)
      _panel : Panel? = nil
      raw = pull.read_raw
      hash = JSON.parse(raw)

      case hash["type"].as_s
      when "row"
        _panel = Row.from_json(raw)
      when "graph"
        _panel = Graph.from_json(raw)
      when "table"
        _panel = Table.from_json(raw)
      when "text"
        _panel = Text.from_json(raw)
      when "singlestat"
        _panel = SingleStat.from_json(raw)
      else
        raise "unknown Panel type: #{hash["type"].as_s}"
      end
      raise "EMPTY PANEL" if _panel.nil?
      _panel
    end
  end
end

require "./panels/*"
