# frozen_string_literal: true

require 'active_record/connection_adapters/postgresql/oid/array'
require 'active_record/enum'

require 'active_record_array_enum/array_enum_methods'
require 'active_record_array_enum/array_enum_type'
require 'active_record_array_enum/version'

require 'active_support/hash_with_indifferent_access'
require 'active_support/core_ext/string/inflections'

module ActiveRecordArrayEnum
  def self.extended(base) # :nodoc:
    base.class_attribute(:defined_array_enums, instance_writer: false, default: {})
  end

  def inherited(base) # :nodoc:
    base.defined_array_enums = defined_array_enums.deep_dup
    super
  end

  def array_enum(name = nil, values = nil, **options)
    if name
      unless values
        values  = options
        options = {}
      end
      return _array_enum(name, values, **options)
    end

    definitions     = options.slice!(:_prefix, :_suffix, :_scopes, :_default)
    options.transform_keys! { |key| :"#{key[1..]}" }
    options[:array] = true

    definitions.each { |k, v| _array_enum(k, v, **options) }
  end

  private

  def _array_enum(name, values, prefix: nil, suffix: nil, scopes: true, **options)
    assert_valid_array_enum_definition_values(values)
    # statuses = { }
    enum_values = ActiveSupport::HashWithIndifferentAccess.new
    name        = name.to_s

    # def self.statuses() statuses end
    detect_enum_conflict!(name, name.pluralize, true)
    singleton_class.define_method(name.pluralize) { enum_values }
    defined_array_enums[name] = enum_values

    detect_enum_conflict!(name, name)
    detect_enum_conflict!(name, "#{name}=")

    attribute(name, **options) do |subtype|
      subtype = subtype.subtype if subtype.is_a?(ArrayEnumType)
      ArrayEnumType.new(name, enum_values, subtype)
    end

    value_method_names = []
    _array_enum_methods_module.module_eval do
      prefix =
        if prefix
          prefix == true ? "#{name}_" : "#{prefix}_"
        end

      suffix =
        if suffix
          suffix == true ? "_#{name}" : "_#{suffix}"
        end

      pairs = values.respond_to?(:each_pair) ? values.each_pair : values.each_with_index
      pairs.each do |label, value|
        enum_values[label] = value
        label              = label.to_s

        value_method_name = "#{prefix}#{label}#{suffix}"
        value_method_names << value_method_name
        define_enum_methods(name, value_method_name, value, scopes)

        method_friendly_label = label.gsub(/[\W&&[:ascii:]]+/, "_")
        value_method_alias    = "#{prefix}#{method_friendly_label}#{suffix}"

        if value_method_alias != value_method_name && value_method_names.exclude?(value_method_alias)
          value_method_names << value_method_alias
          define_enum_methods(name, value_method_alias, value, scopes)
        end
      end
    end
    detect_negative_enum_conditions!(value_method_names) if scopes
    enum_values.freeze
  end

  def _array_enum_methods_module
    @_array_enum_methods_module ||= ArrayEnumMethods.new(self).tap { |mod| include mod }
  end

  def assert_valid_array_enum_definition_values(values)
    raise ArgumentError, "Array enum values #{values} must be either a hash, an array of symbols, or an array of strings." unless values.is_a?(Hash) || values.all?(Symbol) || values.all?(String)

    raise ArgumentError, "Array enum label name must not be blank." if (values.is_a?(Hash) && values.keys.any?(&:blank?)) || (values.is_a?(Array) && values.any?(&:blank?))
  end
end

require 'active_record_array_enum/railtie' if defined?(Rails::Railtie)
