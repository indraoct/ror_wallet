class UsersController < ApplicationController
  skip_before_action :authorized, only: [:login]

  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    if @user.nil?
      render json: {
        status: 404,
        message: 'User not found'
      },status: :not_found
      return false
    end
    render json: @user
  end

  def login
    username =  params[:username]
    password = params[:password]

    if username == "" or password == ""
      render json: {
        status: 401,
        message: "Username or password can't be empty"
      },status: :unauthorized
      return false
    end

    #find username
    @user = User.find_by(username: username)

    if @user.nil?
      render json: {
        status: 401,
        message: "Username not found"
      },status: :unauthorized
      return false
    end


    if @user.authenticate(password) == false
      render json: {
        status: 401,
        message: "Invalid password"
      },status: :unauthorized
      return false
    end

    #generate session_id (JWT)
    user_id_encrypted = EncryptionService.encrypt(@user.id)
    session_id = encode_token({user_id: user_id_encrypted})

    render json: {
      status: 200,
      message: "Login Successful",
      session_id:session_id
    },status:200

  end

end
