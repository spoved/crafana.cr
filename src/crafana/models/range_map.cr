require "json"

module Crafana
  class RangeMap
    include JSON::Serializable

    property from : String

    property text : String

    property to : String
  end
end
