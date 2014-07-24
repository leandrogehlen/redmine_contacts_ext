module Redmine
    module FieldFormat

        class CompanyFieldFormat < RecordList
            add 'company'
            self.customized_class_names = nil            

            def cast_single_value(custom_field, value, customized = nil)
                unless value.blank?
                    Contact.find_by_id(value)
                else
                    nil
                end
            end

            def possible_values_options(custom_field, object = nil)
                Contact.find(:all, :conditions => {:is_company => true}, :order => "first_name").collect{ |c| [ c.to_s, c.id.to_s ] }
            end
        end

    end
end
