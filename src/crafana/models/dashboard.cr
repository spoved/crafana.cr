require "json"
require "./panel"
require "../vars"
require "spoved/logger"

module Crafana
  class Dashboard
    spoved_logger

    include PanelList

    property id : Int32? = nil
    property uid : String = Random::Secure.urlsafe_base64(8)
    property title : String
    property tags = Array(String).new
    property style = Crafana::Vars::DARK_STYLE
    property timezone = Crafana::Vars::UTC
    property editable = true
    property hide_controls : Bool = false
    property time = Crafana::Vars::DEFAULT_TIME
    property time_picker = Crafana::Vars::DEFAULT_TIME_PICKER
    property templating = Templating.new
    property annotations = Array(JSON::Any).new
    property refresh = Crafana::Vars::DEFAULT_REFRESH
    property schema_version = Crafana::Vars::SCHEMA_VERSION
    property version = 0
    property links : Array(JSON::Any) = Array(JSON::Any).new
    property shared_crosshair : Bool = false
    property folder : Crafana::Folder? = nil

    def initialize(
      @title : String,
      @id : Int32? = nil,
      @uid : String = Random::Secure.urlsafe_base64(8),
      @tags = Array(String).new,
      @style = Crafana::Vars::DARK_STYLE,
      @timezone = Crafana::Vars::UTC,
      @editable = true,
      @hide_controls : Bool = false,
      @time = Crafana::Vars::DEFAULT_TIME,
      @time_picker = Crafana::Vars::DEFAULT_TIME_PICKER,
      @templating = Templating.new,
      @annotations : Array(JSON::Any) = Array(JSON::Any).new,
      @refresh = Crafana::Vars::DEFAULT_REFRESH,
      @schema_version = Crafana::Vars::SCHEMA_VERSION,
      @version = 0,
      @links : Array(JSON::Any) = Array(JSON::Any).new,
      @shared_crosshair : Bool = false
    )
      @panel_id = 0
    end

    def next_panel_id
      @panel_id = @panel_id + 1
      @panel_id
    end

    def current_panel_id
      @panel_id
    end

    # Add a *Craffana::Row* to the list of panels
    def add_row(title = "", &block : Crafana::Row ->)
      row = Row.new(dashboard: self, title: title)
      # determine grid pos
      row.grid_pos = GridPos.new((row.height.num/30), 24, 0, 0)
      self.panels << row
      yield row
    end

    def add_template(**args, &block : Crafana::Template ->)
      template = Template.new(**args)
      yield template
      templating << template
    end

    def panels : Array(Crafana::Panel)
      @panels
    end

    def to_json(json)
      update_grid_pos

      json.object do
        json.field "id", id
        json.field "uid", uid
        json.field "title", title
        json.field "tags", tags
        json.field "style", style
        json.field "timezone", timezone
        json.field "editable", editable
        json.field "hideControls", hide_controls
        json.field "graphTooltip", shared_crosshair ? 1 : 0
        json.field "panels", panels
        json.field "time", time
        json.field "timepicker", time_picker

        json.field "templating" do
          json.object do
            json.field "list" do
              json.array do
                templating.each do |template|
                  template.to_json(json)
                end
              end
            end
          end
        end

        json.field "annotations" do
          json.object do
            json.field "list" do
              json.array do
                annotations.each do |anno|
                  anno.to_json(json)
                end
              end
            end
          end
        end

        json.field "refresh", refresh
        json.field "schemaVersion", schema_version
        json.field "version", version
        json.field "links", links
      end
    end

    def self.new(pull : JSON::PullParser)
      _dash = new("")
      pull.read_object do |key|
        case key
        when "id"
          _dash.id = Int32.new(pull)
        when "uid"
          _dash.uid = String.new(pull)
        when "title"
          _dash.title = String.new(pull)
        when "tags"
          _dash.tags = Array(String).new(pull)
        when "style"
          _dash.style = String.new(pull)
        when "timezone"
          _dash.timezone = String.new(pull)
        when "editable"
          _dash.editable = Bool.new(pull)
        when "hideControls"
          _dash.hide_controls = Bool.new(pull)
        when "graphTooltip"
          _dash.shared_crosshair = Int32.new(pull) == 1 ? true : false
        when "panels"
          _dash.panels = Array(Crafana::Panel).new(pull)
        when "time"
          _dash.time = Crafana::Time.new(pull)
        when "timepicker"
          _dash.time_picker = TimePicker.new(pull)
        when "templating"
          pull.read_object do |k|
            if k == "list"
              pull.read_array do
                _dash.templating << Crafana::Template.new(pull)
              end
            end
          end
        when "annotations"
          pull.read_object do |k|
            if k == "list"
              pull.read_array do
                _dash.annotations << JSON::Any.new(pull)
              end
            end
          end
        when "refresh"
          _dash.refresh = String.new(pull)
        when "schemaVersion"
          _dash.schema_version = Int32.new(pull)
        when "version"
          _dash.version = Int32.new(pull)
        when "links"
          _dash.links = Array(JSON::Any).new(pull)
        else
          logger.debug("Unknown json key", "Crafana::Dashboard")
          pull.skip
        end
      end
      _dash
    end
  end
end
