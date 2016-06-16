require 'rest-client'
module ZapierRestHooks
  Struct.new('ZapierApp', :id)
  class Hook < ActiveRecord::Base
    validates :event_name, :target_url, presence: true

    # Looks for an appropriate REST hook that matches the owner, and triggers the hook if one exists.
    def self.trigger(event_name, encoded_record, owner = Struct::ZapierApp.new(0))
      hooks = self.hooks(event_name, owner)
      return if hooks.empty?

      unless Rails.env.development?
        # Trigger each hook if there is more than one for an owner, which can happen.
        hooks.each do |hook|
          Rails.logger.info "Triggering REST hook event: #{event_name} / #{hook.inspect}"
          Rails.logger.info "REST hook record: #{encoded_record}"
          RestClient.post(hook.target_url, encoded_record) do |response|
            if response.code.eql? 410
              Rails.logger.info "Destroying REST hook because of 410 response: #{hook.inspect}"
              hook.destroy
            end
          end
        end
      end
    end

    # Returns all hooks for a given event_name and owner.
    def self.hooks(event_name, owner = Struct::ZapierApp.new(0))
      where(event_name: event_name, owner_class_name: owner.class.name, owner_id: owner.id)
    end

    # Tests whether any hooks exist for a given event_name and owner
    def self.hooks_exist?(event_name, owner = Struct::ZapierApp.new(0))
      hooks(event_name, owner).any?
    end
  end
end
