class ResourcesController < ApplicationController
  require 'json'
  before do
    validate_credentials unless session[:logged_in]

    mangopay_client_id_key = session[:mangopay_client_id]
    mangopay_client_passphrase_key = session[:client_passphrase]
  end

  get '/' do
    redirect to '/users/'
  end

  # events#index
  get '/events/?' do
    @current_page = params[:page] ? params[:page].to_i : 1
    @events = MangoPay::Event.fetch(per_page: 100, page: @current_page)
    haml :'resources/events/index'
  end

  # users#index
  get '/users/?' do
    @current_page = params[:page] ? params[:page].to_i : 1
    @users = MangoPay::User.fetch(per_page: 100, page: @current_page)
    haml :'resources/users/index'
  end

  # payins#index
  get '/payins/?' do
    @payins = MangoPay::PayIn.fetch(params[:user_id])
    haml :'resources/payins/index'
  end

  # users#show
  get '/users/:user_id/' do
    @user = MangoPay::User.fetch(params[:user_id])
    @cards = MangoPay::User.cards(params[:user_id], per_page: 100)
    @wallets = MangoPay::User.wallets(params[:user_id], per_page: 100)
    @transactions = MangoPay::User.transactions(params[:user_id], per_page: 100)
    @bank_accounts = MangoPay::BankAccount.fetch(params[:user_id], per_page: 100)
    haml :'resources/users/show'
  end

  # cards#show
  get '/users/:user_id/cards/:card_id' do
    @user = MangoPay::User.fetch(params[:user_id])
    @card = MangoPay::Card.fetch(params[:card_id])
    haml :'resources/cards/show'
  end

  # wallets#show
  get '/users/:user_id/wallets/:wallet_id' do
    @user = MangoPay::User.fetch(params[:user_id])
    @wallet = MangoPay::Wallet.fetch(params[:wallet_id])
    @transactions = MangoPay::Wallet.transactions(params[:wallet_id], per_page: 100)
    haml :'resources/wallets/show'
  end

  # payins#show
  get '/payins/:payin_id' do
    @payin = MangoPay::PayIn.fetch(params[:payin_id])
    @user = MangoPay::User.fetch(@payin['AuthorId'])
    haml :'resources/payins/show'
  end

  # refunds#show
  get '/refunds/:refund_id' do
    @refund = MangoPay::Refund.fetch(params[:refund_id])
    @user = MangoPay::User.fetch(@refund['AuthorId'])
    haml :'resources/refunds/show'
  end

  # transfers#show
  get '/transfers/:transfer_id' do
    @transfer = MangoPay::Transfer.fetch(params[:transfer_id])
    @from_user = MangoPay::User.fetch(@transfer['AuthorId'])
    @to_user = MangoPay::User.fetch(@transfer['CreditedUserId'])
    haml :'resources/transfers/show'
  end
end
