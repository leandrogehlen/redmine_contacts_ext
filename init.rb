if Redmine::VERSION::MAJOR == 2 && Redmine::VERSION::MINOR >= 5
    require 'redmine'
    
    unless defined?(Redmine::CustomFieldFormat)
        require_dependency 'company_field_format'
    end

    if defined?(Redmine::CustomFieldFormat)
        Redmine::CustomFieldFormat.map do |fields|   
            fields.register CompanyFieldFormat.new('company', :only => %w(Issue Project), :edit_as => 'list')
        end
    end 
else
    Redmine::CustomFieldFormat.map do |fields|   
        fields.register CompanyCustomFieldFormat.new('company', :label => :label_crm_company, :only => %w(Issue Project), :edit_as => 'list')
    end
    ActionDispatch::Reloader.to_prepare do 
        require_dependency 'patches/custom_field_patch'
        require_dependency 'patches/query_patch'
    end
end

Redmine::Plugin.register :redmine_contacts_ext do
  name 'Redmine Contacts Extension Plugin'
  author 'Leandro Guindani Gehlen'
  description 'Provide additional resources for corporate control'
  version '0.0.2'
  url 'https://github.com/leandrogehlen/redmine_contacts_ext'
  author_url 'http://leandrogehlen.github.com/sobre'
  
  requires_redmine :version_or_higher => '2.1.2'
  #requires_redmine_plugin :redmine_contacts, :version_or_higher => '3.2.1'
end
