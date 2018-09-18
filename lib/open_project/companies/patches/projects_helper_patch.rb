module OpenProject
  module Companies
    module Patches
      module ProjectsHelperPatch
        def self.included(base) # :nodoc:
          base.class_eval do
            unloadable
          end
        end

        def render_project_list(projects)
          s = ''

          if projects.any?
            s << "<ul class='projects root'>"
            projects.each do |project|
              s << "<li class='root'><div class='root'>" +
                    link_to_project(project, {}, :class => "project #{User.current.member_of?(project) ? 'my-project' : nil}")
              s << "<div class='wiki description'>#{format_text(project.short_description, :project => project)}</div>" unless project.description.blank?
              s << "</div></li>\n"
            end
            s << "</ul>"
          end

          s.html_safe
        end
      end
    end
  end
end
