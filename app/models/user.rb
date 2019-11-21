class User < ApplicationRecord
     has_secure_password
     has_many :posts, dependent: :destroy
     has_many :comments, dependent: :destroy

     has_many :accepted_sent_requests, -> { where accepted: true }, foreign_key: :requester_id, class_name: 'Request'
     has_many :friends, through: :accepted_sent_requests, source: :requestee
   
     has_many :sent_requests, foreign_key: :requester_id, class_name: 'Request', dependent: :destroy
     has_many :requestees, through: :sent_requests, dependent: :destroy
     
     has_many :received_requests, foreign_key: :requestee_id, class_name: 'Request', dependent: :destroy
     has_many :requesters, through: :received_requests, dependent: :destroy

     has_many :conversations, :foreign_key => :sender_id
end