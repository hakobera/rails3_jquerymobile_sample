require 'spec_helper'

describe "Task pages" do

	subject { page }

	let!(:t1) { FactoryGirl.create(:task, title: 'My Task One', deadline_at: 2.days.since) }
	let!(:t2) { FactoryGirl.create(:task, title: 'My Task Two', deadline_at: 1.days.since) }

  describe "index page" do
  	before { visit tasks_path }
   	it { should have_selector('h1', text: 'Tasks') }
   	it { should have_selector('ul a:first-child', text: 'My Task Two') }
   	it { should have_selector('ul a:last-child', text: 'My Task One') }
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
end
