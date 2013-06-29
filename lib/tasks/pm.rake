namespace :pm do
  task :import => :environment do
    PocketMoney.import
  end
end
