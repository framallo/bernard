namespace :pm do
  desc 'import pocket money database'
  task :import => :environment do
    PocketMoney.import
    AddCategories.categories
  end

  #desc 'add category_id to transactions'
  #task :categories => :environment do
    #AddCategories.categories
  #end
end
