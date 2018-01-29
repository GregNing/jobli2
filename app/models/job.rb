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
    scope :descbycreated, ->{ order("created_at DESC") }
    scope :descbywage_upper_bound, ->{ order("wage_upper_bound DESC") }
    scope :descbywage_lower_bound, ->{ order("wage_lower_bound DESC") }
    scope :published!, ->{ where(is_hidden: false) }    
end
