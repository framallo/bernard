namespace :pm do
  desc 'import pocket money database'
  task :import => :environment do
    PocketMoney.import
  end
end
