require "json"

module Crafana
  class Evaluator
    include JSON::Serializable

    @[JSON::Field(key: "type")]
    property eval_type : String

    property params : Array(String) = Array(String).new

    def self.greater_than(value)
      Evaluator.new(eval_type: EVAL_GT, params: [value])
    end

    def self.lower_than(value)
      Evaluator.new(eval_type: EVAL_LT, params: [value])
    end

    def self.within_range(from_value, to_value)
      Evaluator.new(eval_type: EVAL_WITHIN_RANGE, params: [from_value, to_value])
    end

    def self.outside_range(from_value, to_value)
      Evaluator.new(eval_type: EVAL_OUTSIDE_RANGE, params: [from_value, to_value])
    end

    def self.no_value
      Evaluator.new(eval_type: EVAL_NO_VALUE, params: [from_value, to_value])
    end
  end
end
