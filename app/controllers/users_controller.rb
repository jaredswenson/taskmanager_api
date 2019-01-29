class UsersController < ApplicationController
	skip_before_action :authenticate_request, only: %i[login register getuserbyemail resetpassword]
  require 'sendgrid-ruby'
  include SendGrid
	# POST /register
  def register
    @user = User.create(user_params)
   if @user.save
    response = { message: 'User created successfully'}
    render json: response, status: :created 
   else
    render json: @user.errors, status: :bad
   end 
  end

  def login
    authenticate params[:email], params[:password]
  end

  #POST /getuserbyemail 
  def getuserbyemail
    @user = User.where(email: params[:email]);
    @code = rand.to_s[2..7]
    from = SendGrid::Email.new(email: 'jswen15@gmail.com')
    to = SendGrid::Email.new(email: params[:email])
    subject = 'Donezo Password Reset'
    content = SendGrid::Content.new(type: 'text/plain', value: 'Your password reset code is ' + @code);
    mail = SendGrid::Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: '')
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
    render json: {
      user: @user,
      code: @code
    }
  end

  #POST /resetpassword 
  def resetpassword
    @email = params[:email];
    @password = params[:password]
    @user = User.where(email: @email).first();
    puts "USER #{@user}"
    id = @user[:id];
    User.update(id, password: @password)
    render json: {
          message: "Success!",
        }
  end

  private
	def authenticate(email, password)
    command = AuthenticateUser.call(email, password)

    if command.success?
      puts User.where(email: email)
      render json: {
        access_token: command.result,
        message: 'Login Successful',
        user: User.where(email: email)
      }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
   end

  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :is_premium
    )
  end
end
