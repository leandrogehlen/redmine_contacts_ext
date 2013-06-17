require_dependency 'custom_field'

module CustomFieldPatch

    def self.included(base)        
        base.send(:include, OverridePossibleValuesOptionsMethod)
        base.class_eval do
          unloadable

          alias_method_chain :possible_values_options, :override
        end        
    end

    module OverridePossibleValuesOptionsMethod

        def possible_values_options_with_override(obj = nil)
            case field_format
            when 'company'                
                Contact.find(:all, :conditions => {:is_company => true}, :order => "first_name").collect{ |c| [ c.to_s, c.id.to_s ] }
            else
                possible_values_options_without_override(obj)
            end
        end

    end
end

unless CustomField.included_modules.include?(CustomFieldPatch)
  CustomField.send(:include, CustomFieldPatch)
end
