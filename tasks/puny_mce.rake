VERSION = '1.0.1'

namespace :puny_mce do
  desc 'Install the PunyMCE scripts into the public/javascripts directory of this application'
  task :install => ['puny_mce:add_or_replace_puny_mce']

  desc 'Update the PunyMCE scripts installed at public/javascripts/tiny_mce for this application'
  task :update => ['puny_mce:add_or_replace_puny_mce']

  desc 'Remove the PunyMCE scripts installed at public/javascripts/tiny_mce for this application'
  task :uninstall => ['puny_mce:remove_puny_mce']

  task :add_or_replace_puny_mce do
    require 'fileutils'
    dest = "#{RAILS_ROOT}/public/javascripts/punymce"
    if File.exists?(dest)
      # upgrade
      begin
        puts "Removing directory #{dest}..."
        FileUtils.rm_rf dest
        puts "Recreating directory #{dest}..."
        FileUtils.mkdir_p dest
        puts "Installing PunyMCE version #{VERSION} to #{dest}..."
        FileUtils.cp_r "#{RAILS_ROOT}/vendor/plugins/puny_mce/public/javascripts/punymce/.", dest
        puts "Successfully updated PunyMCE to version #{VERSION}."
      rescue
        puts "ERROR: Problem updating PunyMCE. Please manually copy "
        puts "#{RAILS_ROOT}/vendor/plugins/puny_mce/public/javascripts/punymce"
        puts "to"
        puts "#{dest}"
      end
    else
      # install
      begin
        puts "Creating directory #{dest}..."
        FileUtils.mkdir_p dest
        puts "Installing PunyMCE version #{VERSION} to #{dest}..."
        FileUtils.cp_r "#{RAILS_ROOT}/vendor/plugins/puny_mce/public/javascripts/punymce/.", dest
        puts "Successfully installed PunyMCE version #{VERSION}."
      rescue
        puts "ERROR: Problem installing PunyMCE. Please manually copy "
        puts "#{RAILS_ROOT}/vendor/plugins/puny_mce/public/javascripts/punymce"
        puts "to"
        puts "#{dest}"
      end
    end
  end

  task :remove_puny_mce do
    require 'fileutils'
    dest = "#{RAILS_ROOT}/public/javascripts/punymce"
    if File.exists?(dest)
       begin
        puts "Removing directory #{dest}..."
        FileUtils.rm_rf dest
        puts "Successfully removed PunyMCE directory"
        rescue
        puts "ERROR: Problem removing PunyMCE. Please manually remove #{dest}"
       end
    else
      puts "ERROR: No PunyMCE directory found in #{dest}"
    end
  end

end