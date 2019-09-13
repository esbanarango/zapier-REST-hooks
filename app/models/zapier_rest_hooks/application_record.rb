# frozen_string_literal: true

module ZapierRestHooks
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
