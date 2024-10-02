class User < ApplicationRecord
  has_secure_password

  # Optional validations
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  has_one :wallet, dependent: :destroy
  has_many :sent_transactions, class_name: "Transaction", foreign_key: "sender_id"
  has_many :received_transactions, class_name: "Transaction", foreign_key: "receiver_id"

  # Common method to perform transactions between users
  def perform_transaction(receiver, amount, description = nil)
    ActiveRecord::Base.transaction do
      wallet.withdraw(amount)
      receiver.wallet.deposit(amount)
      Transaction.create!(sender: self, receiver: receiver, amount: amount, description: description)
    end
  end
end
