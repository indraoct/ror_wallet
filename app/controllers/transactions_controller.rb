class TransactionsController < ApplicationController
  # Create a new transaction between two users
  def create
    sender = User.find(params[:sender_id])
    receiver = User.find(params[:receiver_id])
    amount = params[:amount].to_f

    if amount <= 0
      return render json: { error: "Amount must be greater than zero" }, status: :unprocessable_entity
    end

    begin
      # Perform the transaction
      sender.perform_transaction(receiver, amount, params[:description])
      render json: { message: "Transaction successful", sender: sender.wallet, receiver: receiver.wallet }, status: :ok
    rescue => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end
end
