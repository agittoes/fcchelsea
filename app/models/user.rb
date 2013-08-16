class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, type: String
  field :password, type: String

  field :admin, type: Boolean, :default => false

  field :nickname, type: String
  field :first_name, type: String
  field :last_name, type: String

  field :image, type: String

  field :credentials, type: Hash
  field :urls, type: Hash
  field :last_oauth_provider, type: String

  def self.oauth(auth)
    user = User.find_or_create_by :email => auth.info.email
    user.update_oauth_info(auth)

    return user
  end

  def admin?
    !!self.admin
  end

  
  def update_oauth_info(auth)
    self.last_oauth_provider = auth.provider

    self.credentials ||= {}
    self.credentials[auth.provider] = auth.credentials

    self.urls ||= {}
    self.urls.merge! Hash[auth.info.urls.to_h.map {|k, v| [k.downcase, v]}]

    self.nickname = auth.info.nickname

    self.first_name = auth.info.first_name
    self.last_name = auth.info.last_name

    self.image = auth.info.image

    save!
  end

  def facebook
    return nil unless self.credentials.include? 'facebook'
    @facebook ||= Koala::Facebook::API.new(self.credentials['facebook']['token'])
  end

  def nick
    self.nickname || "#{self.first_name} #{self.last_name}"
  end
end
