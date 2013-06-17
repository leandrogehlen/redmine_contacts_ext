Redmine::CustomFieldFormat.map do |fields|   
  fields.register CompanyFieldFormat.new('company', :label => :label_company, :only => %w(Issue Project), :edit_as => 'list')
end

Redmine::Plugin.register :redmine_company do
  name 'Redmine Company plugin'
  author 'Leandro Guindani Gehlen'
  description 'Provide additional resources for corporate control'
  version '0.0.1'
  url 'https://github.com/leandrogehlen/redmine_company'
  author_url 'http://leandrogehlen.github.com/sobre'
  
  requires_redmine :version_or_higher => '2.1.2'
  #requires_redmine_plugin :redmine_contacts, :version_or_higher => '3.2.1'
end

ActionDispatch::Reloader.to_prepare do 
  require_dependency 'patches/custom_field_patch'
  require_dependency 'patches/query_patch'
end
