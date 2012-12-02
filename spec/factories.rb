FactoryGirl.define do 
	factory :task do
		title 'My task'
		deadline_at 1.days.since
		is_complete false
	end
end