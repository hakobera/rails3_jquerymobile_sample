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

require 'spec_helper'

describe Task do

	before do 
		@task = Task.new(title: 'My task', deadline_at: 1.days.since)
	end

	subject { @task }

	it { should respond_to(:title) }
	it { should respond_to(:deadline_at) }
	it { should respond_to(:is_complete) }
	specify { @task.is_complete.should be_false }

	it { should be_valid }

	describe "when title is not present" do
		before { @task.title = "" }
		it { should_not be_valid }
	end

	describe "when title is too long" do
		before { @task.title = "a" * 101 }
		it { should_not be_valid }
	end

	describe "when deadline_at is not present" do
		before { @task.deadline_at = nil }
		it { should_not be_valid }
	end

end