class CreateZapierRestHooksHooks < ActiveRecord::Migration
  def change
    create_table :zapier_rest_hooks_hooks do |t|
      t.string :event_name
      t.string :owner_id
      t.string :owner_class_name
      t.string :subscription_url
      t.string :target_url

      t.timestamps null: false
    end
  end
end
