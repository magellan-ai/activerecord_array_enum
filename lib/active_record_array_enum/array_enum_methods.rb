# frozen_string_literal: true

module ActiveRecordArrayEnum
  class ArrayEnumMethods < Module # :nodoc:
    def initialize(klass)
      @klass = klass
    end

    private

    attr_reader :klass

    def define_enum_methods(name, value_method_name, value, scopes)
      # def active?() status_for_database.values.include?(0) end
      klass.send(:detect_enum_conflict!, name, "#{value_method_name}?")
      define_method("#{value_method_name}?") { public_send(:"#{name}_for_database").values.include?(value) }

      # def active!() update!(status: status_for_database.values | [0]) end
      klass.send(:detect_enum_conflict!, name, "#{value_method_name}!")
      define_method("#{value_method_name}!") { update!(name => public_send(:"#{name}_for_database").values | [value]) }

      # def not_active!() update!(status: status_for_database.values - [0]) end
      klass.send(:detect_enum_conflict!, name, "not_#{value_method_name}!")
      define_method("not_#{value_method_name}!") { update!(name => public_send(:"#{name}_for_database").values - [value]) }

      return unless scopes

      # scope :with_all_statuses, ->(subset) { where(arel_table[:status].contains(subset)) }
      # scope :with_exact_statuses, ->(subset) { where(arel_table[:status].eq(subset)) }
      # scope :with_any_statuses, ->(subset) { where(arel_table[:status].overlaps(subset)) }
      {
        "with_all_#{name.pluralize}"   => :contains,
        "with_exact_#{name.pluralize}" => :eq,
        "with_any_#{name.pluralize}"   => :overlaps
      }.each do |method_name, comparison_operator|
        klass.send(:detect_enum_conflict!, name, method_name, true)
        klass.scope method_name.to_sym, ->(*subset) { where(klass.arel_table[name].public_send(comparison_operator, subset.flatten)) }
      end
    end
  end

  private_constant :ArrayEnumMethods
end
