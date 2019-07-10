require "json"

class Crafana::User
  include JSON::Serializable

  @[JSON::Field(key: "orgId")]
  property org_id : Int32

  @[JSON::Field(key: "userId")]
  property user_id : Int32

  property email : String

  @[JSON::Field(key: "avatarUrl")]
  property avatar_url : String

  property login : String

  property role : String

  @[JSON::Field(key: "lastSeenAt")]
  property last_seen_at : String

  @[JSON::Field(key: "lastSeenAtAge")]
  property last_seen_at_age : String
end
