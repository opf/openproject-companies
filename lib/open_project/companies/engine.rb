# Prevent load-order problems in case openproject-plugins is listed after a plugin in the Gemfile
# or not at all
require 'open_project/plugins'

module OpenProject
  module Companies
    class Engine < ::Rails::Engine
      engine_name :openproject_companies

      include OpenProject::Plugins::ActsAsOpEngine

      class << self
        def settings
          {
            partial: 'settings/companies',
            default: {
              'top_text' => '',
              'bottom_text' => '',
              'auto_calculate_proyects' => false
            }
          }
        end
      end

      register(
        'openproject-companies',
        author_url: 'https://openproject.org',
        requires_openproject: '>= 6.0.0',
        settings: settings
      ) do
        menu :admin_menu,
             :companies,
             {
               controller: 'settings',
               action: 'plugin',
               id: 'openproject_companies'
             },
             caption: 'Companies',
             icon: 'icon2 icon-backlogs'

        menu :top_menu,
             :companies,
             {
               controller: 'companies',
               action: 'index'
             },
             caption: 'Companies',
             after: :projects

        permission :view_companies, companies: [:show, :index]
      end

      patches [
        :CustomFieldsHelper,
        :Project,
        :ProjectsHelper,
        :User
      ]

      assets %w(companies/companies.css companies/companies.js)
    end
  end
end
