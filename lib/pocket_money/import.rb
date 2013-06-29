class PocketMoney

  def self.import
    Import.new
  end

  class Import
    def initialize
      transactions
    end


    def transaction(pocketmoney_transaction)

      puts pocketmoney_transaction.serverID
      t = ::Transaction.where(pm_server_id: pocketmoney_transaction.serverID).first ||
          ::Transaction.new

      #t.pm_deleted             = pocketmoney_transaction.deleted,
      t.pm_type                 = pocketmoney_transaction.type,
      t.pm_account_id           = pocketmoney_transaction.accountID,
    
      t.pm_sub_total            = pocketmoney_transaction.subTotal,
      t.pm_of_x_id              = pocketmoney_transaction.ofxID,
      t.pm_image                = pocketmoney_transaction.image,
      t.pm_overdraft_id         = pocketmoney_transaction.overdraftID,

      t.date                = Time.at(pocketmoney_transaction.date),
      #t.account_id             = t.,
      t.deleted                 = pocketmoney_transaction.deleted,
      t.check_number            = pocketmoney_transaction.checkNumber,
      t.payee_name              = pocketmoney_transaction.payee.force_encoding('Windows-1252').encode('UTF-8'),
      t.amount                  = pocketmoney.subTotal,
      t.cleared                 = !!pocketmoney_transaction.cleared,
      t.uuid                    = pocketmoney_transaction.serverID,
      t.created_at           ||= Time.at(pocketmoney_transaction.date),
      t.updated_at           ||= Time.at(pocketmoney_transaction.timestamp),

      # pocketmoney doesn't store it here
      #t.currency_id            = pm_t.,
      #t.currency_exchange_rate = pm_t.,
      #t.balance                = pm_t.,
      #t.payee_id               = pm_t.,
      #t.category_id            = pm_t.,
      #t.department_id          = pm_t.,
      #t.memo                   = pm_t.,

      binding.pry if pocketmoney_transaction.serverID == '8651AADF-2FFD-42C2-B8C0-09221681202F'

      t.save

    end

    def transactions
      r = Transactions.all.map {|t| t.payee }

      Transactions.all.each do |pocketmoney_transaction| 
        transaction(pocketmoney_transaction) 
      end 
    end

  end # Import
end


