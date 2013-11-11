namespace :pm do
  desc 'import pocket money database'
  task :import => :environment do
    PocketMoney.import
    AddCategories.categories
  end

end
