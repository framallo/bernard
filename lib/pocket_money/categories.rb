class AddCategories
  def self.categories
    transactions = Transaction.all
    transactions.each do |t|
      t.category_id = t.splits.first.category_id
      t.save
    end
  end
end
