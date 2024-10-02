# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# User.create([
#         {
#           username: 'indra',
#           password: 'Pass12345'
#         },
#         {
#           username: 'indra2',
#           password: 'Pass12346'
#         }
# ])
#
# Wallet.create([
#           {
#             users_id: 1,
#             balance: 500000.00
#           },
#           {
#             users_id: 2,
#             balance: 500000.00
#           }
#
# ])

# Clear existing data
Transaction.delete_all
Wallet.delete_all
User.delete_all

# Create Customer Users
customer1 = User.create(username: 'indra1', password: 'Password12345')
customer2 = User.create(username: 'indra2', password: 'Password12346')

# Create wallets for Admin Users with initial balances
customer1.create_wallet(balance: 5000.0)
customer2.create_wallet(balance: 3000.0)

# Create transactions between Admin Users and Customer Users
Transaction.create!(sender: customer2, receiver: customer1, amount: 200.0, description: 'Payment for services')
Transaction.create!(sender: customer1, receiver: customer2, amount: 300.0, description: 'Invoice payment')

# Create transactions between Customers
Transaction.create!(sender: customer1, receiver: customer2, amount: 100.0, description: 'Loan repayment')

puts "Seeding completed!"