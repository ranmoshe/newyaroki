require 'active_record/fixtures'

namespace :db do

  desc "Seed prod data"
  task :init_prod  => :environment do
    # load initial database fixtures into the current environment's database
    ActiveRecord::Base.establish_connection(RAILS_ENV.to_sym)
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.delete_sql("delete from #{t}") unless ["schema_migrations"].include?(t)
    end
    Dir.glob(File.join(SiteExtension.root, "db", 'init_prod', '*.{yml,csv}')).each do |fixture_file|
      # say fixture_file + ' is the current file in migration'
      Fixtures.create_fixtures("#{SiteExtension.root}/db/init_prod/", File.basename(fixture_file, '.*'))
    end
    s = Spree::Setup.new
    s.create_admin_user('raniyoti', 'rani.moshe@gmail.com')
    s.create_admin_user('yotirani', 'yotuina@gmail.com')
  end
end

namespace :spree do
  namespace :extensions do
    namespace :site do
      desc "Copies public assets of the Site to the instance public/ directory."
      task :update => :environment do
        is_svn_git_or_dir = proc {|path| path =~ /\.svn/ || path =~ /\.git/ || File.directory?(path) }
        Dir[SiteExtension.root + "/public/**/*"].reject(&is_svn_git_or_dir).each do |file|
          path = file.sub(SiteExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
