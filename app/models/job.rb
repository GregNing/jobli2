# == Schema Information
#
# Table name: jobs
#
#  id               :integer          not null, primary key
#  title            :string
#  description      :text
#  wage_upper_bound :integer
#  wage_lower_bound :integer
#  contact_email    :string
#  is_hidden        :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Job < ApplicationRecord
    belongs_to :user
    has_many :resumes
    scope :descbycreated, ->{ order("created_at DESC") }
    scope :descbywage_upper_bound, ->{ order("wage_upper_bound DESC") }
    scope :descbywage_lower_bound, ->{ order("wage_lower_bound DESC") }
    scope :published, ->{ where(is_hidden: false) }    

    validates :title, :description, presence: {message: "必填!"}
    validates :contact_email, email_format: { message: "請使用Email 做為聯繫資訊!" }
    validates :wage_upper_bound, numericality: { greater_than:0 , message: "必須為數字，且大於0!" }
    validates :wage_lower_bound, numericality: { greater_than:0 , message: "必須為數字，且大於0!" }

    def publish!
        self.is_hidden = false
        self.save
    end
    def hide!
        self.is_hidden = true
        self.save
    end
end
