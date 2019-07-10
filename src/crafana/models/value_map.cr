require "json"

module Crafana
  class ValueMap
    include JSON::Serializable

    property op : String
    property text : String
    property value : String

    def initialize(@op, @text, @value)
    end
  end

  class RangeMap
    include JSON::Serializable

    property from : String
    property to : String
    property text : String

    def initialize(@from, @to, @text)
    end
  end
end
