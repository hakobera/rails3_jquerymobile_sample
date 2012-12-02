# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  deadline_at :date
#  is_complete :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Task < ActiveRecord::Base
  attr_accessible :deadline_at, :is_complete, :title

  validates :title, presence: true, length: { maximum: 100 }
  validates :deadline_at, presence: true

  default_scope order: 'tasks.deadline_at DESC'
end
