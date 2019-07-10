require "json"

module Crafana
  class Org
    include JSON::Serializable

    property id : Int32

    property name : String

    property address : Address
  end

  class Address
    include JSON::Serializable

    property address1 : String

    property address2 : String

    property city : String

    @[JSON::Field(key: "zipCode")]
    property zip_code : String

    property state : String

    property country : String
  end
end
