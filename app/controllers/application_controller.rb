class ApplicationController < ActionController::API
  before_action :authorized
  def encode_token(payload)
    JWT.encode(payload, 's3cr3t')
  end

  def decoded_token
    header = request.headers['Authorization']
    if header
      token = header.split(" ")[1]
      begin
        JWT.decode(token, 's3cr3t')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def current_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      user_id_decoded = EncryptionService.decrypt(user_id)
      @user = User.find_by(id: user_id_decoded)
    end
  end

  def authorized
    unless !!current_user
      render json: { status: 401,message: 'Please log in' }, status: :unauthorized
    end
  end
end
