
class PocketMoney
  module BaseTable
    def self.included(main)
      main.establish_connection(adapter: :sqlite3, database: APP_CONFIG['pocket_money_database'])
      main.table_name = main.name.demodulize.sub(/(\w)/) {|w| w.downcase}
      main.inheritance_column = "rails_type"
    end
  end

  class Accounts < ActiveRecord::Base
    include BaseTable

  end
  class Categories < ActiveRecord::Base
    include BaseTable

  end
  class CategoryBudgets  < ActiveRecord::Base
    #db version 29
    include BaseTable

  end
  class Categorypayee < ActiveRecord::Base
    include BaseTable

  end
  class Classes < ActiveRecord::Base
    include BaseTable

  end
  class DatabaseSyncList < ActiveRecord::Base
    include BaseTable

  end
  class ExchangeRates < ActiveRecord::Base
    include BaseTable

  end
  class Filters < ActiveRecord::Base
    include BaseTable

  end
  class Ids < ActiveRecord::Base
    include BaseTable

  end
  class Payees < ActiveRecord::Base
    include BaseTable

  end
  class Preferences < ActiveRecord::Base
    include BaseTable

  end
  class RepeatingTransactions < ActiveRecord::Base
    include BaseTable

  end
  class Splits < ActiveRecord::Base
    include BaseTable
  end

  class Transactions < ActiveRecord::Base
    include BaseTable
  end
end
