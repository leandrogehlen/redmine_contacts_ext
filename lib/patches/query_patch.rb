require_dependency 'query'

module QueryPatch

    def self.included(base)
        base.send(:include, InstanceMethods)        
        base.class_eval do
            unloadable

            alias_method_chain :add_custom_fields_filters, :override            
        end
    end

    module InstanceMethods

        def add_custom_fields_filters_with_override(custom_fields, assoc = nil)
            add_custom_fields_filters_without_override(custom_fields, assoc)

            custom_fields.select(&:is_filter?).each do |field|
                case field.field_format
                when "company"
                    options = { :type => :list_optional, :values => field.possible_values_options, :order => 20 }
                end
                filter_id = "cf_#{field.id}"
                filter_name = field.name
                if assoc.present?
                    filter_id = "#{assoc}.#{filter_id}"
                    filter_name = l("label_attribute_of_#{assoc}", :name => filter_name)
                end
                @available_filters[filter_id] = options.merge({ :name => filter_name, :format => field.field_format }) if options
            end
        end
    end
end

unless Query.included_modules.include?(QueryPatch)
  Query.send(:include, QueryPatch)
end
