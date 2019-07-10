require "json"
require "../vars"

module Crafana
  class Tooltip
    include JSON::Serializable

    @[JSON::Field(key: "msResolution")]
    property ms_resolution : Bool = true

    property shared : Bool = true

    property sort : Int32 = 0

    property value_type : String = Crafana::Vars::CUMULATIVE
  end
end
