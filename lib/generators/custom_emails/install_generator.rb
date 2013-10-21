module CustomEmails
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../../templates', __FILE__)

    desc 'Copy the initializer for configuring custom_emails'

    def copy_initializer
      copy_file 'custom_emails.rb', 'config/initializers/custom_emails.rb'
    end
  end
end
