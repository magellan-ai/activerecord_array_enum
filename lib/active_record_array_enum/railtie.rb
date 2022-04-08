# frozen_string_literal: true

module ActiveRecordArrayEnum
  require 'rails'

  class Railtie < Rails::Railtie
    initializer 'active_record.array_enum.load' do
      ActiveRecord::Base.extend ActiveRecordArrayEnum
    end
  end
end
