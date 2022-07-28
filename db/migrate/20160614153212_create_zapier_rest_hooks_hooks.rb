# frozen_string_literal: true

class CreateZapierRestHooksHooks < ActiveRecord::Migration[6.1]
  def change
    create_table :zapier_rest_hooks_hooks do |t|
      t.string :event_name
      t.string :subscription_url
      t.string :target_url

      t.timestamps null: false
    end
  end
end
