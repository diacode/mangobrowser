class ResourcesController < ApplicationController
  require 'json'

  before do
    validate_credentials
    event_types
  end

  get '/' do
    redirect to '/users/'
  end

  # events#index
  get '/events/?' do
    @current_page = params[:page] ? params[:page].to_i : 1
    @pagination = { per_page: 50, page: @current_page }
    @events = MangoPay::Event.fetch(@pagination)
    haml :'resources/events/index'
  end

  get '/events/:event_type' do
    @current_page = params[:page] ? params[:page].to_i : 1
    @pagination = { per_page: 50, page: @current_page, 'EventType' => params[:event_type].upcase }
    @events = MangoPay::Event.fetch(@pagination)
    haml :'resources/events/index'
  end

  # users#index
  get '/users/?' do
    @current_page = params[:page] ? params[:page].to_i : 1
    @pagination = { per_page: 50, page: @current_page }
    @users = MangoPay::User.fetch(@pagination)
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
    @bank_accounts = MangoPay::BankAccount.fetch(params[:user_id], per_page: 100)

    @current_page = params[:page] ? params[:page].to_i : 1
    @pagination = { per_page: 10, page: @current_page, sort: 'CreationDate:desc' }
    @transactions = MangoPay::User.transactions(params[:user_id], @pagination)
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
    @current_page = params[:page] ? params[:page].to_i : 1

    @current_page = params[:page] ? params[:page].to_i : 1
    @pagination = { per_page: 20, page: @current_page, sort: 'CreationDate:desc' }
    @transactions = MangoPay::Wallet.transactions(params[:wallet_id], @pagination)
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

  # pay_outs#show
  get '/pay_outs/:pay_out_id' do
    @pay_out = MangoPay::PayOut.fetch(params[:pay_out_id])
    @user = MangoPay::User.fetch(@pay_out['AuthorId'])

    haml :'resources/pay_outs/show'
  end
end
