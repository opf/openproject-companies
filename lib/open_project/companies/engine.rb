# Prevent load-order problems in case openproject-plugins is listed after a plugin in the Gemfile
# or not at all
require 'open_project/plugins'

module OpenProject::Companies
  class Engine < ::Rails::Engine
    engine_name :openproject_companies

    include OpenProject::Plugins::ActsAsOpEngine

    register 'openproject-companies',
             :author_url => 'https://openproject.org',
             :requires_openproject => '>= 6.0.0'

  end
end
