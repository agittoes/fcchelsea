Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  provider :facebook, '621275447917435', '5fd400e313ffb8e662375f63b4a92fb5', :scope => 'email,user_likes,publish_actions'

  OmniAuth.config.on_failure = SessionsController.action(:auth_failure)
end
