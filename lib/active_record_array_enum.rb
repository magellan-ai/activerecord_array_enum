# frozen_string_literal: true

require 'active_record/enum'

module ActiveRecordArrayEnum
  def self.load; end
end

require 'active_record_array_enum/railtie' if defined?(Rails::Railtie)
