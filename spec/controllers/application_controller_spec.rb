require './spec/spec_helper'

describe ApplicationController do

  describe "GET /" do
    it 'renders the page' do
      get "/"
      last_response.should be_ok
    end
  end

  %w(login).each do |page|
    describe "GET /#{page}" do
      it 'renders the page' do
        get "/#{page}/"
        last_response.should be_ok
      end
    end
  end

  describe "GET /logout" do

    before do
      get "/logout/"
    end

    it "clears session" do
      last_response.should be_redirect
      follow_redirect!
      last_response.should be_ok
    end

    it "sets alert message" do
      last_response.should be_redirect
      follow_redirect!
      last_response.body.should include("You have logged out.")
    end
  end

  describe "POST /login" do
    it "sets configuration params" do
      MangoPay::User.stub(:fetch)

      post "/login", { mangopay_client_id: "client_id", mangopay_client_passphrase: "passphrase" }

      c = MangoPay.configuration
      c.preproduction.should be_false
      c.client_id.should eq('client_id')
      c.client_passphrase.should eq('passphrase')
    end

    context "when successful" do
      before do
        MangoPay::User.stub(:fetch)
        post "/login", { mangopay_client_id: "client_id", mangopay_client_passphrase: "passphrase" }
      end

      it "redirects to /resources/users" do
        last_response.should be_redirect
        follow_redirect!
        last_request.path.should == "/resources/users/"
      end
    end

    context "when unsuccessful" do
      before do
        MangoPay::User.stub(:fetch).and_raise(MangoPay::ResponseError.new({}, {}, {}))
        post "/login", { mangopay_client_id: "client_id", mangopay_client_passphrase: "passphrase" }
      end

      it "redirects to home" do
        last_response.should be_redirect
        follow_redirect!
        last_request.path.should == "/"
      end

      it "sets flash notice message" do
        last_response.should be_redirect
        follow_redirect!
        last_request.env["x-rack.flash"].should_not be_nil
      end
    end
  end
end
