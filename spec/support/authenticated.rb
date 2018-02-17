RSpec.shared_examples 'authenticated' do
  before do
    authenticate
  end

  def authenticate
    page.driver.browser.authorize(user, password)
  end

  def user
    ENV['ADMIN_USERNAME']
  end

  def password
    ENV['ADMIN_PASSWORD']
  end
end
