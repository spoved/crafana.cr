require "json"
require "../panel"

module Crafana
  class Row < Crafana::Panel
    include JSON::Serializable

    include PanelList

    property collapsed : Bool = false
    property height : Pixels = Crafana::Vars::DEFAULT_ROW_HEIGHT
    @[JSON::Field(key: "showTitle")]
    property show_title : Bool = true

    def initialize(@dashboard : Crafana::Dashboard? = nil, @title = "",
                   @collapsed = false,
                   @height = Crafana::Vars::DEFAULT_ROW_HEIGHT,
                   @panels = Array(Crafana::Panel).new,
                   @show_title = true)
      @panel_type = Crafana::Vars::ROW_TYPE
      @id = @dashboard.as(Crafana::Dashboard).next_panel_id unless @dashboard.nil?
    end
  end
end
