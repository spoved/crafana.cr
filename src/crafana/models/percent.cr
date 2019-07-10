require "json"

module Crafana
  class Percent
    include JSON::Serializable

    property num : Int32

    def initialize(@num)
    end

    def self.new(pull : JSON::PullParser)
      val = pull.read_string
      if val =~ /^(\d+)\%$/
        new $1.to_i32
      else
        new val.to_i32
      end
    end

    def to_json(json : ::JSON::Builder)
      json.string "#{num}%"
    end
  end
end
