require 'spec_helper'

describe "Admin index" do
  include Rack::Test::Methods

  def app
    Hanami.app
  end

  it "is unauthorized without auth" do
    get "/admin"

    expect(last_response.status).to eq 401
  end

  it "is unauthorized with bad auth" do
    encoded_login = ["bad:credentials"].pack('m0')
    header('Authorization', "Basic #{encoded_login}")
    get "/admin"

    expect(last_response.status).to eq 401
  end

  it "is succesful with valid auth" do
    username = ENV.fetch('ADMIN_USERNAME', 'hanami')
    password = ENV.fetch('ADMIN_PASSWORD', 'hanami')
    encoded_login = ["#{username}:#{password}"].pack('m0')
    header('Authorization', "Basic #{encoded_login}")
    get "/admin"

    expect(last_response.status).to eq 200
  end
end
