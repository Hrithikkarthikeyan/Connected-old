namespace :views do
  desc "TODO"
  task delete_7_days_old: :environment do
    View.where(['created_at < ?', 7.days.ago]).destroy_all
  end

end
