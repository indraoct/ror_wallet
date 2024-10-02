class Wallet < ApplicationRecord
  belongs_to :user
  has_many :sent_transactions, class_name: "Transaction", foreign_key: "sender_id"
  has_many :received_transactions, class_name: "Transaction", foreign_key: "receiver_id"

  def deposit(amount)
    self.balance += amount
    save!
  end

  def withdraw(amount)
    if balance >= amount
      self.balance -= amount
      save!
    else
      raise "Insufficient funds"
    end
  end
end
