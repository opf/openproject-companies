module OpenProject
  module Companies
    class Hooks < Redmine::Hook::ViewListener
      # :project
      # :form
      render_on :view_projects_show_right, partial: 'projects/companies'
      render_on :view_account_left_bottom, partial: 'users/companies'
    end
  end
end
