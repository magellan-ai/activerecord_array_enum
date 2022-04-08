# frozen_string_literal: true

module ActiveRecordArrayEnum
  class ArrayEnumType < ActiveRecord::ConnectionAdapters::PostgreSQL::OID::Array # :nodoc:
    attr_reader :subtype

    delegate :type, to: :subtype

    def initialize(name, mapping, subtype)
      @name    = name
      @mapping = mapping
      @subtype = subtype
      super(subtype)
    end

    def cast(value)
      value.map do |element|
        if mapping.key?(element)
          element.to_s
        elsif mapping.value?(element)
          mapping.key(element)
        else
          element.presence
        end
      end
    end

    def deserialize(value)
      subtype.deserialize(value)&.map { |element| mapping.key(element) }
    end

    def serialize(value)
      subtype.serialize(serialize_elements(value))
    end

    def serializable?(value, &block)
      subtype.serializable?(serialize_elements(value), &block)
    end

    def assert_valid_value(value)
      raise ArgumentError, "Must assign an array to #{name}" unless value.respond_to?(:each)

      value.each do |element|
        raise ArgumentError, "'#{element}' is not a valid #{name.singularize}" unless element.blank? || mapping.key?(element) || mapping.value?(element)
      end
    end

    private

    attr_reader :name, :mapping

    def serialize_elements(array)
      array.map { |element| mapping.fetch(element, element) }
    end
  end
end
