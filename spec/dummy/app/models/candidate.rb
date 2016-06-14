class Candidate < ActiveRecord::Base
  # Relations
  belongs_to :organization

  # Callbacks
  after_create :trigger_hooks

  private

  def trigger_hooks
    if ZapierRestHooks::Hook.hooks_exist?('new_candidate', organization)
      ZapierRestHooks::Hook.trigger('new_candidate', organization, self)
    end
  end
end
