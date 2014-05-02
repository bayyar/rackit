class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login

  has_many :product_preferences, class_name: "UserProductPreference", foreign_key: "user_id"

  has_many :user_friendships
  has_many :friends, through: :user_friendships

  # validates :name, presence: true
  validates :username, presence: true, uniqueness: {case_sensitive: false}, format: /\A[-a-z]+\Z/i

  def racked_products
  	product_preferences.where(is_racked: true)
  end

  # Returns array of users being followed by USER
  def following
    user_friendships
  end

  # Returns array of users following the USER
  def self.followers(user)
    User.joins(:user_friendships).where({ user_friendships: { friend_id: user.id }}).order(:username)
  end

  # Scope method to get all users except the one passed.
  
  def self.all_except(user)
    User.where(arel_table[:id].not_eq(user.id)).order(:name)
  end

  # Overwrites Devise's find_for_database_authentication method in User model.
  # Because we want to change the behavior of the login action, we have to overwrite the find_for_database_authentication method

  def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions).first
      end
    end

end
