module OpenProject
  module Companies
    module Patches
      module ProjectPatch
        def self.included(base) # :nodoc:
          base.class_eval do
            has_and_belongs_to_many :companies

            scope :like, lambda { |q|
              s = "%#{q.to_s.strip.downcase}%"

              where("LOWER(identifier) LIKE :s OR LOWER(name) LIKE :s", { s: s })
            }

            scope :sorted_alphabetically, -> { order(name: :asc) }

            def all_companies
              if Setting.plugin_openproject_companies['auto_calculate_projects']
                co = []
                users.each do |u|
                  co << u.company_ids
                end

                Company.where(id: co.uniq).order(name: :asc)
              else
                companies.all.order(name: :asc)
              end
            end
          end
        end
      end
    end
  end
end
