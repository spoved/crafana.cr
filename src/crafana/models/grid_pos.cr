require "json"

module Crafana
  class GridPos
    include JSON::Serializable

    property h : Int32

    property w : Int32

    property x : Int32

    property y : Int32

    def initialize(@h, @w, @x, @y)
    end
  end
end
