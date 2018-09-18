module OpenProject
  module Companies
    module Traits
      module CustomFieldsHelper
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

CustomFieldsHelper.prepend OpenProject::Companies::Traits::CustomFieldsHelper
