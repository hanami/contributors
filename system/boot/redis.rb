Application.finalize(:redis) do |container|
  init do
    if Hanami.env?(:production)
      uri = URI.parse(ENV.fetch("REDISTOGO_URL"))
      redis = ConnectionPool.new(size: 10, timeout: 3) { Redis.new(driver: :hiredis, host: uri.host, port: uri.port, password: uri.password) }
    elsif Hanami.env?(:test)
      redis = ConnectionPool.new(size: 10, timeout: 3) { MockRedis.new }
    else
      redis = ConnectionPool.new(size: 10, timeout: 3) { Redis.new(host: 'localhost', port: 6379) }
    end

    container.register(:redis, redis)
  end
end
