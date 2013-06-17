class CompanyFieldFormat < Redmine::CustomFieldFormat

    def format_as_company(value)
        Contact.find(value).name
    rescue
        nil
    end
    
end
