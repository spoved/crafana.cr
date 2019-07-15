require "json"
require "yaml"

class Crafana::DataSource
  KEY_ALIAS = {
    "folder_id"           => "folderId",
    "org_id"              => "orgId",
    "secure_json_data"    => "secureJsonData",
    "with_credentials"    => "withCredentials",
    "basic_auth"          => "basicAuth",
    "is_default"          => "isDefault",
    "json_data"           => "jsonData",
    "basic_auth_user"     => "basicAuthUser",
    "basic_auth_password" => "basicAuthPassword",
    "is_folder"           => "isFolder",
    "has_acl"             => "hasAcl",
    "plugin_id"           => "pluginId",
    "read_only"           => "readOnly",
  }

  def initialize(@name, @data_source_type)
  end

  include JSON::Serializable
  include YAML::Serializable

  property id : Int32?

  @[JSON::Field(key: "type")]
  @[YAML::Field(key: "type")]
  property data_source_type : String

  property name : String

  property access : String = "proxy"

  @[JSON::Field(key: "basicAuth")]
  property basic_auth : Bool = false

  @[JSON::Field(key: "isDefault")]
  property is_default : Bool = false

  @[JSON::Field(key: "jsonData")]
  property json_data : JsonData?

  @[JSON::Field(key: "withCredentials")]
  property with_credentials : Bool = false

  @[JSON::Field(key: "secureJsonData")]
  property secure_json_data : SecureJsonData?

  @[JSON::Field(key: "readOnly")]
  property read_only : Bool?

  property url : String?

  property database : String?

  @[JSON::Field(key: "basicAuthUser")]
  property basic_auth_user : String?

  @[JSON::Field(key: "basicAuthPassword")]
  property basic_auth_password : String?

  property password : String?

  property user : String?

  class JsonData
    alias MaxConcurrentShardRequests = Int32 | String
    include JSON::Serializable
    include YAML::Serializable

    @[JSON::Field(key: "authType")]
    property auth_type : String?

    @[JSON::Field(key: "defaultRegion")]
    property default_region : String?

    @[JSON::Field(key: "timeField")]
    property time_field : String?

    @[JSON::Field(key: "esVersion")]
    property es_version : Int32?

    property interval : String?

    # @[JSON::Field(key: "keepCookies")]
    # property keep_cookies : Array(JSON::Any?)?

    @[JSON::Field(key: "maxConcurrentShardRequests")]
    property max_concurrent_shard_requests : MaxConcurrentShardRequests?

    @[JSON::Field(key: "oauthPassThru")]
    property oauth_pass_thru : Bool?

    @[JSON::Field(key: "tlsAuth")]
    property tls_auth : Bool?

    @[JSON::Field(key: "tlsSkipVerify")]
    property tls_skip_verify : Bool?

    @[JSON::Field(key: "graphiteVersion")]
    property graphite_version : String?

    @[JSON::Field(key: "httpMethod")]
    property http_method : String?

    @[JSON::Field(key: "queryTimeout")]
    property query_timeout : String?

    @[JSON::Field(key: "timeInterval")]
    property time_interval : String?
  end

  class SecureJsonData
    include JSON::Serializable
    include YAML::Serializable

    @[JSON::Field(key: "accessKey")]
    property access_key : String?

    @[JSON::Field(key: "secretKey")]
    property secret_key : String?

    @[JSON::Field(key: "basicAuthPassword")]
    property basic_auth_password : String?
  end
end
