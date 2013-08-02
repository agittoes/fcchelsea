class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, type: String
  field :password, type: String

  field :nickname, type: String
  field :first_name, type: String
  field :last_name, type: String

  field :image, type: String

  field :oauth, type: Hash
  field :last_oauth_provider, type: String

  def self.oauth(auth)
    user = User.find_or_create_by :email => auth.info.email
    user.update_oauth_info(auth)

    return user
  end

  
  def update_oauth_info(auth)
    self.last_oauth_provider = auth.provider

    self.oauth ||= {}
    self.oauth[auth.provider] = auth

    self.nickname = auth.info.nickname

    self.first_name = auth.info.first_name
    self.last_name = auth.info.last_name

    self.image = auth.info.image

    save!
  end
end
