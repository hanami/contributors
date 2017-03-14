require "net/https"

class HttpRequest
  def initialize(url)
    @uri = URI.parse(url)
  end

  def get
    request = Net::HTTP::Get.new(uri.request_uri)
    yield request if block_given?

    http(uri).request(request)
  end

private

  attr_reader :uri

  def http(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http
  end
end
