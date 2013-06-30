class PocketMoney

  def self.import
    Import.new
  end

  class Import
    def initialize
      accounts
      transactions
    end


    def transaction(pocketmoney_transaction)

      puts "Transaction: " + pocketmoney_transaction.serverID

      t = ::Transaction.where(uuid: pocketmoney_transaction.serverID).first ||
          ::Transaction.new

      t.pm_type                 = pocketmoney_transaction.type
      t.pm_id                   = pocketmoney_transaction.accountID
    
      t.pm_sub_total            = pocketmoney_transaction.subTotal
      t.pm_of_x_id              = pocketmoney_transaction.ofxID
      t.pm_image                = pocketmoney_transaction.image
      t.pm_overdraft_id         = pocketmoney_transaction.overdraftID

      t.date                    = to_time(pocketmoney_transaction.date)
      t.account_id              = find_account_id(pocketmoney_transaction.accountID)
      t.deleted                 = pocketmoney_transaction.deleted
      t.check_number            = pocketmoney_transaction.checkNumber
      t.payee_name              = pocketmoney_transaction.payee.force_encoding('Windows-1252').encode('UTF-8')
      t.amount                  = pocketmoney_transaction.subTotal
      t.cleared                 = !!pocketmoney_transaction.cleared
      t.uuid                    = pocketmoney_transaction.serverID
      t.created_at           ||= to_time(pocketmoney_transaction.date)
      t.updated_at           ||= to_time(pocketmoney_transaction.timestamp)

      # pocketmoney doesn't store it here
      #t.currency_id            = pm_t.
      #t.currency_exchange_rate = pm_t.
      #t.balance                = pm_t.
      #t.payee_id               = pm_t.
      #t.category_id            = pm_t.
      #t.department_id          = pm_t.
      #t.memo                   = pm_t.

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

      a.save
    end

  end # Import
end


