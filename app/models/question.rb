# == Schema Information
#
# Table name: questions
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Question < ActiveRecord::Base
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :answers, dependent: :destroy

  validates_presence_of :title, :description
end
