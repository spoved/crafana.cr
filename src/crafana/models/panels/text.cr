require "json"
require "../panel"

module Crafana
  # Generates a Text panel
  class Text < Crafana::Panel
    include JSON::Serializable

    property content : String = ""
    property height : Pixels = Crafana::Vars::DEFAULT_ROW_HEIGHT
    getter panel_type : String = Crafana::Vars::TEXT_TYPE
    property links : Array(JSON::Any) = Array(JSON::Any).new
    property mode : String = Crafana::Vars::TEXT_MODE_MARKDOWN
    property span : String?

    def initialize(@dashboard : Crafana::Dashboard? = nil)
      @panel_type = Crafana::Vars::TEXT_TYPE
      @id = @dashboard.as(Crafana::Dashboard).next_panel_id unless @dashboard.nil?
    end
  end
end
