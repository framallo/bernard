class PocketMoney


  def self.import
    Import.new.process
  end

  class Import
    def process
      accounts
      transactions
      categories
      groups          #classes
      splits
      ids
      payees
#     categorypayee
#     categorybudgets     
    end


    def transaction(pocketmoney_transaction)

      puts "Transaction: " + pocketmoney_transaction.serverID

      t = ::Transaction.where(uuid: pocketmoney_transaction.serverID).first ||
          ::Transaction.new

      t.pm_id                   = pocketmoney_transaction.transactionID
      t.deleted                 = pocketmoney_transaction.deleted
      t.pm_type                 = pocketmoney_transaction.type
      t.date                    = to_time(pocketmoney_transaction.date)
      t.cleared                 = !!pocketmoney_transaction.cleared
      t.account_id              = find_account_id(pocketmoney_transaction.accountID)
      t.pm_payee                = pocketmoney_transaction.payee.force_encoding('Windows-1252').encode('UTF-8')
      t.check_number            = pocketmoney_transaction.checkNumber
      t.amount                  = pocketmoney_transaction.subTotal
      t.ofx_id                  = pocketmoney_transaction.ofxID
      t.uuid                    = pocketmoney_transaction.serverID
      t.overdraft_id            = pocketmoney_transaction.overdraftID

      t.created_at           ||= to_time(pocketmoney_transaction.date)
      t.updated_at           ||= to_time(pocketmoney_transaction.timestamp)

      t.save!

    end

    def to_time(t)
      Time.zone.at(t)
    end

    def find_account_id(pm_account_id)
      ::Account.where(pm_id: pm_account_id.to_i).first.try(:id)
    end

    def transactions
      Transactions.all.each do |pocketmoney_transaction| 
        transaction(pocketmoney_transaction) 
      end 
    end


    def accounts
      Accounts.all.each do |pocketmoney_account| 
        account(pocketmoney_account) 
      end 
    end

    def account(pocketmoney_account)

      puts "Account: " + pocketmoney_account.serverID

      a = ::Account.where(uuid: pocketmoney_account.serverID).first ||
          ::Account.new

      a.deleted                    = !!pocketmoney_account.deleted
      a.updated_at                 = to_time(pocketmoney_account.timestamp)
      a.pm_id                      = pocketmoney_account.accountID
      a.display_order              = pocketmoney_account.displayOrder
      a.name                       = pocketmoney_account.account
      a.balance_overall            = pocketmoney_account.balanceOverall
      a.balance_cleared            = pocketmoney_account.balanceCleared
      a.pm_account_type            = pocketmoney_account.type
      a.number                     = pocketmoney_account.accountNumber
      a.institution                = pocketmoney_account.institution
      a.phone                      = pocketmoney_account.phone
      a.expiration_date            = pocketmoney_account.expirationDate
      a.check_number               = pocketmoney_account.checkNumber
      a.notes                      = pocketmoney_account.notes
      a.pm_icon                    = pocketmoney_account.iconFileName
      a.url                        = pocketmoney_account.url
      a.of_x_id                    = pocketmoney_account.ofxid
      a.of_x_url                   = pocketmoney_account.ofxurl
      a.password                   = pocketmoney_account.password
      a.fee                        = pocketmoney_account.fee
      a.fixed_percent              = pocketmoney_account.fixedPercent
      a.limit_amount               = pocketmoney_account.limitAmount
      a.limit                      = pocketmoney_account.noLimit
      a.total_worth                = pocketmoney_account.totalWorth
      a.exchange_rate              = pocketmoney_account.exchangeRate
      a.currency_code              = pocketmoney_account.currencyCode
      a.last_sync_time             = pocketmoney_account.lastSyncTime
      a.routing_number             = pocketmoney_account.routingNumber
      a.overdraft_account_id       = pocketmoney_account.overdraftAccountID
      a.keep_the_change_account_id = pocketmoney_account.keepTheChangeAccountID
      a.heek_change_round_to       = pocketmoney_account.keepChangeRoundTo
      a.uuid                       = pocketmoney_account.serverID

      a.save!
    end

    def payees
      Payees.all.each do |pocketmoney_payee| 
        payee(pocketmoney_payee) 
      end 
    end

    def payee(pocketmoney_payee)

      puts "Payee: " + pocketmoney_payee.serverID

      p = ::Payee.where(uuid: pocketmoney_payee.serverID).first ||
          ::Payee.new

      p.deleted                    = !!pocketmoney_payee.deleted
      p.pm_id                      = pocketmoney_payee.payeeID
      p.name                       = pocketmoney_payee.payee
      p.latitude                   = pocketmoney_payee.latitude
      p.longitude                  = pocketmoney_payee.longitude
      p.uuid                       = pocketmoney_payee.serverID

      p.created_at               ||= to_time(pocketmoney_payee.timestamp)
      p.updated_at               ||= to_time(pocketmoney_payee.timestamp)

      p.save!
   end

    def categories
      Categories.all.each do |pocketmoney_category| 
        category(pocketmoney_category) 
      end 
    end

    def category(pocketmoney_category)

      puts "Category: " + pocketmoney_category.serverID

      c = ::Category.where(uuid: pocketmoney_category.serverID).first ||
          ::Category.new

      c.deleted                    = !!pocketmoney_category.deleted
      c.category_id                = pocketmoney_category.categoryID
      c.name                       = pocketmoney_category.category
      c.pm_type                    = pocketmoney_category.type
      c.budget_period              = pocketmoney_category.budgetPeriod
      c.budget_limit               = pocketmoney_category.budgetLimit  
      c.include_sub_categories     = pocketmoney_category.includeSubcategories  
      c.rollover                   = pocketmoney_category.rollover  
      c.uuid                       = pocketmoney_category.serverID

      c.created_at               ||= to_time(pocketmoney_category.timestamp)
      c.updated_at               ||= to_time(pocketmoney_category.timestamp)

      c.save!
    end 

    def groups
      Classes.all.each do |pocketmoney_group| 
        group(pocketmoney_group) 
      end 
    end

    def group(pocketmoney_group)
      puts "Group: " + pocketmoney_group.serverID

      d = ::Group.where(uuid: pocketmoney_group.serverID).first ||
        ::Group.new

      d.deleted            = !!pocketmoney_group.deleted
      d.created_at       ||= to_time(pocketmoney_group.timestamp)
      d.updated_at       ||= to_time(pocketmoney_group.timestamp)
      d.pm_id              = pocketmoney_group.classID
      d.name               = pocketmoney_group.pm_class
      d.uuid               = pocketmoney_group.serverID

      d.save!
    end 

    def ids
      Ids.all.each do |pocketmoney_id| 
        id(pocketmoney_id) 
      end 
    end

    def id(pocketmoney_id)

      puts "Id: " + pocketmoney_id.serverID

      i = ::Id.where(uuid: pocketmoney_id.serverID).first ||
          ::Id.new

      i.deleted             = !!pocketmoney_id.deleted
      i.id_id               = pocketmoney_id.idID
      i.pm_id               = pocketmoney_id.id
      i.uuid                = pocketmoney_id.serverID

      i.created_at        ||= to_time(pocketmoney_id.timestamp)
      i.updated_at        ||= to_time(pocketmoney_id.timestamp)

      i.save!
    end 

    def find_transaction_id(a_pm_id)
      ::Transaction.where(pm_id:  a_pm_id).first.try(:id)
    end

    def find_category_id(categoryID)
      ::Category.where(name:  categoryID).first.try(:id)
    end

    def find_group_id(classID)
      ::Group.where(name:  classID).first.try(:id)
    end

    def splits
      Splits.all.each do |pocketmoney_split| 
        split(pocketmoney_split) 
      end 
    end

    def split(pocketmoney_split)

      puts "Split: " + pocketmoney_split.splitID.to_s

      s = ::Split.where(pm_id: pocketmoney_split.splitID).first ||
          ::Split.new

      s.transaction_id          = find_transaction_id(pocketmoney_split.transactionID) 
      s.category_id             = find_category_id(pocketmoney_split.categoryID)
      s.amount                  = pocketmoney_split.amount
      s.xrate                   = pocketmoney_split.xrate
      s.group_id                = find_group_id(pocketmoney_split.classID)  
      s.memo                    = pocketmoney_split.memo  
      s.transfer_to_account_id  = pocketmoney_split.transferToAccountID
      s.currency_code           = pocketmoney_split.currencyCode
      s.pm_id                   = pocketmoney_split.splitID
      s.ofxid                   = pocketmoney_split.ofxid

      s.save!
    end 

  end # Import
#      s.transaction_id          = Transaction.where("pm_id = s.transaction_id").select(:id)   

end


