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

  def safe_name
    self.name.gsub(/[\s\.\-]/, '_').downcase
  end

  def to_tf_vars
    terr = String::Builder.new
    terr << <<-END
    variable #{safe_name} {
      default = {
        "url" = "#{url}"
        "username" = "#{user}"
        "password" = "#{password}"
        "basic_auth_username" = "#{basic_auth_user}"
        "basic_auth_password" = "#{basic_auth_password}"
      }
    }\n\n
    END

    if !secure_json_data.nil? && !secure_json_data.as(SecureJsonData).to_tf(safe_name).empty?
      data = secure_json_data.as(SecureJsonData)
      terr << <<-END
      variable #{safe_name}_secure_json_data {
        default = {
          "access_key" = "#{data.access_key}"
          "secret_key" = "#{data.secret_key}"
        }
      }\n\n
      END
    end

    terr.to_s
  end

  def to_tf_vars_def
    <<-END
    variable "#{safe_name}" {
      type = "map"
      default = {
        "username" = ""
        "password" = ""
        "basic_auth_user" = ""
        "basic_auth_password" = ""
      }
    }

    variable "#{safe_name}_secure_json_data" {
      type = "map"
      default = {
        "access_key" = ""
        "secret_key" = ""
      }
    }\n\n
    END
  end

  def to_tf
    terr = String::Builder.new
    terr << "resource \"grafana_data_source\" \"#{safe_name}\" {\n"
    # Required
    terr << "  type = \"#{data_source_type}\"\n"
    terr << "  name = \"#{name}\"\n"

    # Optional
    if url.is_a?(String)
      terr << "  url = var.#{safe_name}.url\n" unless url.as(String).empty?
    end

    if !is_default.nil?
      terr << "  is_default = \"#{is_default}\"\n"
    end

    if !basic_auth.nil?
      terr << "  basic_auth_enabled = \"#{basic_auth}\"\n"
      if basic_auth
        terr << "  basic_auth_username = var.#{safe_name}.basic_auth_username\n"
        terr << "  basic_auth_password = var.#{safe_name}.basic_auth_password\n"
      end
    end

    if user && !user.as(String).empty?
      terr << "  username = var.#{safe_name}.username\n"
      terr << "  password = var.#{safe_name}.password\n"
    end

    if database && !database.as(String).empty?
      terr << "  database_name = \"#{database}\"\n"
    end

    if access && !access.empty?
      terr << "  access_mode = \"#{access}\"\n"
    end

    if !json_data.nil? && !json_data.as(JsonData).to_tf.empty?
      terr << "\n"
      terr << "  json_data {\n"
      terr << json_data.as(JsonData).to_tf
      terr << "  }\n"
    end

    if !secure_json_data.nil? && !secure_json_data.as(SecureJsonData).to_tf(safe_name).empty?
      terr << "\n"
      terr << "  secure_json_data {\n"
      terr << secure_json_data.as(SecureJsonData).to_tf(safe_name)
      terr << "  }\n"
    end
    terr << "}\n\n"
    terr.to_s
  end

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

    def to_tf
      terr = String::Builder.new
      if !auth_type.nil? && !auth_type.as(String).empty?
        terr << "    auth_type = \"#{auth_type}\"\n"
      end

      if !default_region.nil? && !default_region.as(String).empty?
        terr << "    default_region = \"#{default_region}\"\n"
      end

      terr.to_s
    end
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

    def to_tf(safe_name)
      terr = String::Builder.new
      terr << "    access_key = var.#{safe_name}_secure_json_data.access_key\n"
      terr << "    secret_key = var.#{safe_name}_secure_json_data.secret_key\n"

      # if !basic_auth_password.nil? && !basic_auth_password.as(String).empty?
      #   terr << "    basic_auth_password = var.#{safe_name}_secure_json_data.basic_auth_password\n"
      # end

      terr.to_s
    end
  end
end
