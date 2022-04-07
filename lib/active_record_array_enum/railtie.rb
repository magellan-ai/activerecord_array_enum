# frozen_string_literal: true

module ActiveRecordArrayEnum
  require 'rails'

  class Railtie < Rails::Railtie
    initializer "active_record.array_enum.load" do
      ActiveSupport.on_load :active_record do
        ActiveRecordArrayEnum.load
      end
    end
  end
end
