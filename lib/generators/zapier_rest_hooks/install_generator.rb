
require 'rails/generators/base'
class ZapierRestHooks::InstallGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.expand_path('../templates', __FILE__)
  require 'rails/generators/migration'

  desc "Mounts ZapierRestHooks in routes and copies migrations."

  def mount_in_routes
    route "mount ZapierRestHooks::Engine, at: \"/hooks\""
  end

  def copy_migrations
    require 'rake'
    Rails.application.load_tasks
    Rake::Task['railties:install:migrations'].reenable
    Rake::Task['zapier_rest_hooks:install:migrations'].invoke
  end
end
