require "json"

module Crafana
  class Pixels
    include JSON::Serializable

    def initialize(@num : Int32)
    end

    property num : Int32

    def self.new(pull : JSON::PullParser)
      val = pull.read_string
      if val =~ /^(\d+)px$/
        new $1.to_i32
      else
        new val.to_i32
      end
    end

    def to_json(json : ::JSON::Builder)
      json.string "#{num}px"
    end
  end
end
