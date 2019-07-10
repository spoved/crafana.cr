require "json"

module Crafana
  class Mapping
    include JSON::Serializable

    property name : String

    property value : Int32

    def initialize(@name, @value)
    end
  end
end
