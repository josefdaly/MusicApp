# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  after_initialize :ensure_session_token
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :email, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  attr_reader :password

  def self.find_by_credentials(email, password)
    current_user = User.find_by(email: email)
    if current_user && current_user.is_password?(password)
      return current_user
    end
    nil
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = nil
    self.session_token = User.generate_session_token
    self.save
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end
