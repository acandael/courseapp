class User < ActiveRecord::Base
 validates_presence_of :email, :password, :full_name
 validates_uniqueness_of :email

 has_secure_password validations: false
 validates :password, presence: true, length: { minimum: 6 }

 has_many :responses
 has_many :answers, through: :responses
 has_many :quiz_completions
 has_many :quizzes, through: :quiz_completions
end
