Bernard::Application.load_tasks
Rake::Task['db:drop'].invoke
Rake::Task['db:create'].invoke
Rake::Task['db:migrate'].invoke
PocketMoney.import 

