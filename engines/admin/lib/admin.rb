# frozen_string_literal: true

require "rails"

require "admin/version"

module Admin
  class << self
    # Configure table_name_prefix for all the models from the engine
    # if their could be collision with other engines or the main app
    # (useful during the gradual migration to engined-architecture)
    def table_name_prefix
      ""
    end
  end
end

require "admin/engine"
