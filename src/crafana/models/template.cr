require "json"
require "../vars"

module Crafana
  alias Templating = Array(Template)

  # Template create a new 'variable' for the dashboard, defines the variable
  #     name, human name, query to fetch the values and the default value.
  #         :param default: the default value for the variable
  #         :param dataSource: where to fetch the values for the variable from
  #         :param label: the variable's human label
  #         :param name: the variable's name
  #         :param query: the query users to fetch the valid values of the variable
  #         :param refresh: Controls when to update values in the dropdown
  #         :param allValue: specify a custom all value with regex,
  #             globs or lucene syntax.
  #         :param includeAll: Add a special All option whose value includes
  #             all options.
  #         :param regex: Regex to filter or capture specific parts of the names
  #             return by your data source query.
  #         :param multi: If enabled, the variable will support the selection of
  #             multiple options at the same time.
  #         :param type: The template type, can be one of: query (default),
  #             interval, datasource, custom, constant, adhoc.
  #         :param hide: Hide this variable in the dashboard, can be one of:
  #             SHOW (default), HIDE_LABEL, HIDE_VARIABLE
  class Template
    include JSON::Serializable

    @[JSON::Field(key: "allValue")]
    property all_value : String?

    # FIXME: Current should return the default value
    property current : Current? = nil

    property datasource : String?

    property hide : Int32 = Crafana::Vars::SHOW

    @[JSON::Field(key: "includeAll")]
    property include_all : Bool = false

    property label : String?

    property multi : Bool = false

    property name : String

    property options : Array(JSON::Any) = Array(JSON::Any).new

    property query : String

    property refresh : Int32 = Crafana::Vars::REFRESH_ON_DASHBOARD_LOAD

    property regex : String?

    property sort : Int32 = Crafana::Vars::SORT_ALPHA_ASC

    @[JSON::Field(key: "tagValuesQuery")]
    property tag_values_query : String?

    @[JSON::Field(key: "tagsQuery")]
    property tags_query : String?

    @[JSON::Field(key: "type")]
    property template_type : String = "query"

    @[JSON::Field(key: "useTags")]
    property use_tags : Bool = false

    def initialize(@name, @template_type, @query)
    end

    class Current
      include JSON::Serializable

      # property tags : Array(String) = Array(String).new

      property text : String? = nil

      property value : Array(String)? = nil

      def initialize
      end
    end
  end
end
