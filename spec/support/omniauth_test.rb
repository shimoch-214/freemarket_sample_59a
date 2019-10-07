module OmniauthTest
  def facebook_mock
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      {
        provider: 'facebook',
        uid: '12345',
        info: {
          email: 'sample@test.com'
        }
      })
  end

  def google_mock
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      {
        provider: 'google_oauth2',
        uid: '12345',
        info: {
          email: 'sample@test.com'
        }
      })
  end
end