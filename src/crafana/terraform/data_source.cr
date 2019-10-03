module Crafana
  class DataSource
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
      def to_tf
        terr = String::Builder.new
        if !auth_type.nil? && !auth_type.as(String).empty?
          terr << "    auth_type = \"#{auth_type}\"\n"
        end

        if !default_region.nil? && !default_region.as(String).empty?
          terr << "    default_region = \"#{default_region}\"\n"
        end

        if !http_method.nil? && !http_method.as(String).empty?
          terr << "    http_method = \"#{http_method}\"\n"
        end

        if !query_timeout.nil? && !query_timeout.as(String).empty?
          terr << "    query_timeout = \"#{query_timeout}\"\n"
        end

        if !time_interval.nil? && !time_interval.as(String).empty?
          terr << "    time_interval = \"#{time_interval}\"\n"
        end

        terr.to_s
      end
    end

    class SecureJsonData
      def to_tf(safe_name)
        terr = String::Builder.new
        terr << "    access_key = var.#{safe_name}_secure_json_data.access_key\n"
        terr << "    secret_key = var.#{safe_name}_secure_json_data.secret_key\n"

        terr.to_s
      end
    end
  end

  class Folder
    def safe_name
      self.title.gsub(/[\s\.\-]/, '_').downcase
    end

    def to_tf
      terr = String::Builder.new
      terr << "resource \"grafana_folder\" \"#{self.safe_name}\" {\n"
      terr << "  title = \"#{self.title}\"\n"
      terr << "}\n\n"
      terr.to_s
    end

    def tf_id
      "${grafana_folder.#{safe_name}.id}"
    end
  end
end
