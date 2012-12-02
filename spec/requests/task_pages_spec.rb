require 'spec_helper'

describe "Task pages" do

	subject { page }

	let!(:t1) { FactoryGirl.create(:task, title: 'My Task One', deadline_at: 3.days.since) }
	let!(:t2) { FactoryGirl.create(:task, title: 'My Task Two', deadline_at: 2.days.since) }
	let!(:t3) { FactoryGirl.create(:task, title: 'Completed Task', deadline_at: 1.days.since, is_complete: true) }
	let!(:t4) { FactoryGirl.create(:task, title: 'Old Task', deadline_at: 1.days.ago) }

  describe "index page" do
 
  	describe "with no filter parameter shows incompleted task only" do
	  	before { visit tasks_path }
	   	it { should have_selector('h1', text: 'Tasks') }
	   	it { should have_selector('ul a', text: 'My Task One') }
	   	it { should have_selector('ul a', text: 'My Task Two') }
	   	it { should_not have_selector('ul a', text: 'Completed Task') }
	   	it { should_not have_selector('ul a', text: 'Old Task') }
	  end

	  describe "with filter=none shows all tasks"  do
	  	before { visit tasks_path(filter: "none") }
	   	it { should have_selector('h1', text: 'Tasks') }
	   	it { should have_selector('ul a', text: 'My Task One') }
	   	it { should have_selector('ul a', text: 'My Task Two') }
	   	it { should have_selector('ul a', text: 'Completed Task') }	  	
	   	it { should_not have_selector('ul a', text: 'Old Task') }
	  end
  end

  describe "new page" do
  	before { visit new_task_path }
   	it { should have_selector('h1', text: 'Create Task') }
  end

  describe "edit page" do
  	before { visit edit_task_path(t1) }
   	it { should have_selector('h1', text: 'Edit Task') }
   	it { should have_selector('input[type="text"]', value: 'My Task One') }
  end

  describe "task creation" do
  	before { visit new_task_path }

  	describe "with invalid information" do
  		
  		it "should not create a task" do
  			expect { click_button "Create" }.not_to change(Task, :count)
  		end

	  	describe "error messages" do
	  		before { click_button "Create" }
	  		it { should have_content('error') }
	  	end
	  end

  	describe "with valid information" do
  		
  		before { fill_in 'task_title', with: "My Task Three" }
  		it "should create a task" do
  			expect { click_button "Create" }.to change(Task, :count).by(1)
  		end
  	end
  end

  describe "task editing" do
  	before { visit edit_task_path(t1) }

  	describe "with invalid information" do
  		
	  	describe "error messages" do
	  		before {
	  			fill_in 'task_title', with: ""
	  			click_button "Update"
	  		}
	  		it { should have_content('error') }
	  	end
	  end

  	describe "with valid information" do
  		before {
  			fill_in 'task_title', with: "Changed" 
  			click_button "Update"
  		}
  		it "should update a task" do
	  		expect { Task.find_by_id(t1.id).title.should == "Changed" }
  		end
  	end
  end
end
