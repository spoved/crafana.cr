require "json"

module Crafana
  class XAxis
    include JSON::Serializable

    property buckets : Array(JSON::Any)?

    property mode : String = "time"

    property name : String?

    property show : Bool = true

    property values : Array(JSON::Any) = Array(JSON::Any).new

    def initialize(@buckets = nil, @mode = "time", @name = nil, @show = true, @values = Array(JSON::Any).new)
    end
  end
end
