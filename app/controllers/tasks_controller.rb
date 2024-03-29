class TasksController < ApplicationController

	def index
		if params[:filter] == 'none'
			@tasks = Task.where{ (deadline_at >= Date.today) }
		else
			@tasks = Task.where{ (deadline_at >= Date.today) & (is_complete == false) }
		end
	end

	def new
		@task = Task.new
	end

	def edit
		@task = Task.find_by_id(params[:id])
	end

	def create
		@task = Task.new(params[:task])
		if @task.save
			redirect_to tasks_url, notice: 'Task was successfully created.'
		else
			render action: "new"
		end
	end

	def update
		@task = Task.find(params[:id])
		logger.debug(params[:task])

		if @task.update_attributes(params[:task])
			redirect_to tasks_url, notice: 'Task was successfully updated.'
		else
			render action: "edit"
		end
	end
end
