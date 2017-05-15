module OpenProject
  module Companies
    module Patches
      module CustomFieldsHelperPatch
        def self.included(base) # :nodoc:
          base.prepend InstanceMethods
        end

        module InstanceMethods
          def custom_fields_tabs
            tabs = super
            tabs << {
              name: 'CompanyCustomField',
              partial: 'custom_fields/tab',
              label: :label_company_plural
            }

            tabs
          end
        end
      end
    end
  end
end
