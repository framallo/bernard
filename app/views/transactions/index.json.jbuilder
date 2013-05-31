json.array!(@transactions) do |transaction|
  json.extract! transaction, :account_id, :created_at, :check_number, :payee_id, :category_id, :class_id, :memo, :amount, :cleared, :currency_id, :currency_exchange_rate, :balance
  json.url transaction_url(transaction, format: :json)
end