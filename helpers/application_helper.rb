module ApplicationHelper
  require 'mangopay'

  include Sprockets::Helpers

  def validate_credentials
    mangopay_client_id = session[:mangopay_client_id]
    mangopay_client_passphrase = session[:mangopay_client_passphrase]
    mangopay_preproduction = session[:mangopay_preproduction]

    begin
      MangoPay.configure do |c|
        c.preproduction = mangopay_preproduction
        c.client_id = mangopay_client_id
        c.client_passphrase = mangopay_client_passphrase
      end

      MangoPay::User.fetch()

    rescue MangoPay::ResponseError
      session.clear
      flash[:notice] = "Please make sure you are providing valid credentials."
      redirect '/'
    else
      session[:logged_in] = true
    end
  end

  def controller_name
    request.script_name.delete "/"
  end

end
