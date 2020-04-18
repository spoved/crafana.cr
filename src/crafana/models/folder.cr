require "json"
require "./panel"
require "../vars"
require "spoved/logger"

module Crafana
  class Folder
    spoved_logger

    property id : Int32? = nil
    property uid : String = Random::Secure.urlsafe_base64(8)
    property title : String
    property has_acl : Bool = false
    property can_save : Bool = true
    property can_edit : Bool = true
    property can_admin : Bool = true

    def initialize(
      @title : String,
      @id : Int32? = nil,
      @uid : String = Random::Secure.urlsafe_base64(8),
      @has_acl : Bool = false,
      @can_save : Bool = true,
      @can_edit : Bool = true,
      @can_admin : Bool = true
    )
    end

    def to_json(json)
      json.object do
        json.field "id", id
        json.field "uid", uid
        json.field "title", title
        json.field "hasAcl", has_acl
        json.field "canSave", can_save
        json.field "canEdit", can_edit
        json.field "canAdmin", can_admin
      end
    end

    def self.new(pull : JSON::PullParser)
      _dash = new("")
      pull.read_object do |key|
        case key
        when "id"
          _dash.id = Int32.new(pull)
        when "uid"
          _dash.uid = String.new(pull)
        when "title"
          _dash.title = String.new(pull)
        when "hasAcl"
          _dash.has_acl = Bool.new(pull)
        when "canSave"
          _dash.can_save = Bool.new(pull)
        when "canEdit"
          _dash.can_edit = Bool.new(pull)
        when "canAdmin"
          _dash.can_admin = Bool.new(pull)
        else
          logger.debug { "Unknown json key" }
          pull.skip
        end
      end
      _dash
    end
  end
end
