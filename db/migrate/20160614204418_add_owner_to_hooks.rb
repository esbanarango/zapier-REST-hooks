# frozen_string_literal: true

class AddOwnerToHooks < ActiveRecord::Migration[6.1]
  def change
    add_column :zapier_rest_hooks_hooks, :owner_id, :string, default: 0
    add_column :zapier_rest_hooks_hooks, :owner_class_name, :string, default: 'Struct::ZapierApp'
  end
end
