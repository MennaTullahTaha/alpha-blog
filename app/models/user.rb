class User < ApplicationRecord
    before_save {self.email = email.downcase}
    validates :username, presence: true, uniqueness: { case_sensitive: false }, length: {minimum:3, maximum:10}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: { case_sensitive: false }, length: {maximum:102}, format: {with: VALID_EMAIL_REGEX }
    has_many :articles
end 