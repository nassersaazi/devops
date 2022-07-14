task :promote_admin => :environment do
  User.first.update_attribute('admin', true)
end