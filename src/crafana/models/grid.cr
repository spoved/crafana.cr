require "json"
require "../vars"
require "./rgba"

module Crafana
  class Grid
    include JSON::Serializable

    property threshold1 : Nil = nil

    @[JSON::Field(key: "threshold1Color")]
    property threshold1_color : RGBA = Crafana::Vars::GREY1

    property threshold2 : Nil = nil

    @[JSON::Field(key: "threshold2Color")]
    property threshold2_color : RGBA = Crafana::Vars::GREY2
  end
end
