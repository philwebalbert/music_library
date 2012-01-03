require "digest/sha1"
class User < ActiveRecord::Base
  
  attr_accessor :hashed_password
  attr_accessible :name, :hashed_password
  
  validates_presence_of :name, :hashed_password
  validates_uniqueness_of :name
  
  def before_create
    self.hashed_password = User.hash_password(self.hashed_password)
  end
  
  def after_create
    @password = nil
  end
  
  def try_to_login
    User.login(self.name, self.hashed_password)
  end
  
  def self.login( name, password )
    hashed_password = hash_password(password || "")
    self.find(:first, :conditions => ["name = ? AND hashed_password = ?", name, hashed_password])
  end
  
  private #------------------------------------------
  
  def self.hash_password(password)
    Digest::SHA1.hexdigest(password)
  end
end
