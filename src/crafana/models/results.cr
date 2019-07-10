require "json"

class Crafana::Result
  include JSON::Serializable

  property id : Int32

  property uid : String

  property title : String

  property url : String

  @[JSON::Field(key: "type")]
  property result_type : String

  property tags : Array(String)

  @[JSON::Field(key: "isStarred")]
  property is_starred : Bool

  property uri : String
end
