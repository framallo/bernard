class PocketMoney

  def self.import
    Import.new.import
  end

  class Import

    def import
      accounts
      categories
      classes
      transactions
      splits
      payees
      repeating_transactions
    end

    def accounts
      import_table 'Accounts'
    end

    def categories
      import_table 'Categories'
    end

    def classes
      import_table 'Classes', :import_class
    end

    def transactions
      import_table 'Transactions'
    end

    def payees
      import_table 'Payees'
    end

    def splits
      import_table 'Splits'
    end

    def repeating_transactions
      import_table 'RepeatingTransactions'
    end

    private


    def transaction(pm)

      create_or_update(
        ::Transaction,
        {uuid: pm.serverID},
        pm_type:         pm.type,
        pm_id:           pm.transactionID,
        pm_sub_total:    pm.subTotal,
        pm_of_x_id:      pm.ofxID,
        pm_image:        pm.image,
        pm_overdraft_id: pm.overdraftID,
        date:            to_time(pm.date),
        account_id:      find_account_id(pm.accountID),
        deleted:         pm.deleted,
        check_number:    pm.checkNumber,
        payee_name:      pm.payee.force_encoding('Windows-1252').encode('UTF-8'),
        payee_id:        find_payee_id(pm.payee),
        amount:          pm.subTotal,
        cleared:         !!pm.cleared,
        created_at:      to_time(pm.date),
        updated_at:      to_time(pm.timestamp)
      )
    end


    def account(pm)
      create_or_update(
        ::Account, 
        {uuid: pm.serverID},
        deleted:                    !!pm.deleted,
        updated_at:                 to_time(pm.timestamp),
        pm_id:                      pm.accountID,
        display_order:              pm.displayOrder,
        name:                       pm.account,
        balance_overall:            pm.balanceOverall,
        balance_cleared:            pm.balanceCleared,
        pm_account_type:            pm.type,
        number:                     pm.accountNumber,
        institution:                pm.institution,
        phone:                      pm.phone,
        expiration_date:            pm.expirationDate,
        check_number:               pm.checkNumber,
        notes:                      pm.notes,
        pm_icon:                    pm.iconFileName,
        url:                        pm.url,
        of_x_id:                    pm.ofxid,
        of_x_url:                   pm.ofxurl,
        password:                   pm.password,
        fee:                        pm.fee,
        fixed_percent:              pm.fixedPercent,
        limit_amount:               pm.limitAmount,
        limit:                      pm.noLimit,
        total_worth:                pm.totalWorth,
        exchange_rate:              pm.exchangeRate,
        currency_code:              pm.currencyCode,
        last_sync_time:             pm.lastSyncTime,
        routing_number:             pm.routingNumber,
        overdraft_account_id:       pm.overdraftAccountID,
        keep_the_change_account_id: pm.keepTheChangeAccountID,
        heek_change_round_to:       pm.keepChangeRoundTo,
        uuid:                       pm.serverID,
        created_at:                 to_time(pm.timestamp),
        updated_at:                 to_time(pm.timestamp),
      )
    end


    def split(pm)
      create_or_update(
        ::Split, 
        {pm_id: pm.splitID},
        transaction_id:         find_transaction_id(pm.transactionID),
        amount:                 pm.amount,
        xrate:                  pm.xrate,
        category_id:            find_category_id(pm.categoryID),
        class_id:               find_class_id(pm.classID),
        memo:                   pm.memo,
        transfer_to_account_id: find_account_id(pm.transferToAccountID),
        currency_code:          pm.currencyCode,
        of_x_id:                pm.ofxid,
      )
    end


    def category(pm)
      create_or_update(
        ::Category, 
        {uuid: pm.serverID},
        name:                  pm.category,
        deleted:               !!pm.deleted,
        pm_id:                 pm.categoryID,
        pm_type:               pm.type,
        budget_period:         pm.budgetPeriod,
        budget_limit:          pm.budgetLimit,
        include_subcategories: !!pm.includeSubcategories,
        rollover:              !!pm.rollover,
        uuid:                  pm.serverID,
        created_at:            to_time(pm.timestamp),
        updated_at:            to_time(pm.timestamp)
      )
    end

    def payee(pm)
      create_or_update(
        ::Payee,
        {uuid: pm.serverID},
        deleted:    pm.deleted,
        created_at: to_time(pm.timestamp),
        updated_at: to_time(pm.timestamp),
        pm_id:      pm.payeeID,
        name:       pm.payee,
        latitude:   pm.latitude,
        longitude:  pm.longitude,
        uuid:       pm.serverID,
        created_at: to_time(pm.timestamp),
        updated_at: to_time(pm.timestamp),
      )

    end

    def repeating_transaction(pm)
      create_or_update(
        ::RepeatingTransaction,
        {uuid: pm.serverID},
        last_processed_date:     pm.lastProcessedDate,
        transaction_id:          find_transaction_id(pm.transactionID),
        pm_type:                 pm.type,
        end_date:                pm.endDate,
        frequency:               pm.frequency,
        repeat_on:               pm.repeatOn,
        start_of_week:           pm.startOfWeek,
        send_local_notification: pm.sendLocalNotifications,
        notify_days_in_advance:  pm.notifyDaysInAdvance,
        deleted:                 pm.deleted,
        uuid:                    pm.serverID,
        created_at:              to_time(pm.timestamp),
        updated_at:              to_time(pm.timestamp),
      )
    end

    def import_class(pm)
      create_or_update(
        ::Department,
        {uuid: pm.serverID},
        name:                    pm.pm_class,
        pm_id:                   pm.classID,
        uuid:                    pm.serverID,
        deleted:                 pm.deleted,
        created_at:              to_time(pm.timestamp),
        updated_at:              to_time(pm.timestamp),
      )
    end


    # find rails ids

    def find_transaction_id(pm_id)
      ::Transaction.where(pm_id: pm_id.to_i).first.try(:id)
    end

    def find_category_id(pm_id)
      ::Category.where(name: pm_id).first.try(:id)
    end

    def find_payee_id(pm_id)
      ::Payee.where(name: pm_id).first.try(:id)
    end

    def find_class_id(pm_id)

    end

    def find_account_id(pm_account_id)
      ::Account.where(pm_id: pm_account_id.to_i).first.try(:id)
    end

    # more helpers

    def to_time(t)
      Time.zone.at(t)
    end

    def import_table model_string, import_method=nil
      model = "PocketMoney::#{model_string}".constantize
      import_method ||= model_string.to_s.singularize.underscore
      

      progress_bar model
      model.all.each do |pm|
        send(import_method, pm)
        progress_bar_tick
      end

    end

    def progress_bar(model)
      @pb = ProgressBar.create(:title => model.to_s, :total => model.count)
    end

    def progress_bar_tick
      @pb.increment
    end

    def create_or_update(model, find, attrs)
      r = model.where(find).first || model.new
      r.update(find.merge(attrs))
      r.save!
    end


  end # Import
end


