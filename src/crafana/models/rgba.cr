require "json"
require "colors"

module Crafana
  class RGBA
    def initialize(@r, @g, @b, @a)
    end

    property r : Int32
    property g : Int32
    property b : Int32
    property a : Float64

    def to_json(json)
      json.string "rgba(#{r}, #{g}, #{b}, #{a})"
    end

    def self.new(pull : JSON::PullParser)
      val = pull.read_string
      case val
      when /^rgba\((\d+),\s*(\d+),\s*(\d+),\s*([\d\.]+)\)$/
        new $1.to_i32, $2.to_i32, $3.to_i32, $4.to_f64
      when /^#[\w\d]+$/
        _color = Colors::Color.from_s(val)
        new _color.red.to_i, _color.green.to_i, _color.blue.to_i, 1.0
      else
        raise "Unable to desearlize RGBA. Value: #{val}"
      end
    end
  end

  class RGB
    include JSON::Serializable

    def initialize(@r, @g, @b)
    end

    property r : Int32
    property g : Int32
    property b : Int32

    def self.new(pull : JSON::PullParser)
      val = pull.read_string
      case val
      when /^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/
        new $1.to_i32, $2.to_i32, $3.to_i32
      when /^#[\w\d]+$/
        _color = Colors::Color.from_s(val)
        new _color.red.to_i, _color.green.to_i, _color.blue.to_i
      else
        raise "Unable to desearlize RGB. Value: #{val}"
      end
    end

    def to_json(json)
      json.string "rgb(#{r}, #{g}, #{b})"
    end
  end
end
