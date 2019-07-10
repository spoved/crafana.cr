require "json"

module Crafana
  class Time
    include JSON::Serializable

    property from : String
    property to : String

    def initialize(@from, @to)
    end
  end

  class TimePicker
    include JSON::Serializable

    property refresh_intervals : Array(String)
    property time_options : Array(String)

    def initialize(@refresh_intervals, @time_options)
    end
  end

  # A time range for an alert condition.
  #     A condition has to hold for this length of time before triggering.
  #     :param str from_time: Either a number + unit (s: second, m: minute,
  #         h: hour, etc)  e.g. `"5m"` for 5 minutes, or `"now"`.
  #     :param str to_time: Either a number + unit (s: second, m: minute,
  #         h: hour, etc)  e.g. `"5m"` for 5 minutes, or `"now"`.
  class TimeRange
    property from_time : String
    property to_time : String

    def initialize(@from_time : String, @to_time : String)
    end

    def to_json(json : ::JSON::Builder)
      json.array do
        json.string from_time
        json.string to_time
      end
    end

    def self.new(pull : JSON::PullParser)
      a = Array.new(pull)
      new(a.first, a.last)
    end
  end
end
