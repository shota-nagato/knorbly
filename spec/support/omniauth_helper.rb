module OmniauthHelper
  def mock_auth_hash(provider, uid:, email:, name:)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[provider.to_sym] = OmniAuth::AuthHash.new({
      provider: provider,
      uid: uid,
      info: {
        email: email,
        name: name
      }
    })
  end
end
