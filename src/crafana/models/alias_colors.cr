require "json"

module Crafana
  class AliasColors
    include JSON::Serializable

    property green : String
    property red : String
    property yellow : String

    def initialize(@green, @red, @yellow)
    end
  end
end
