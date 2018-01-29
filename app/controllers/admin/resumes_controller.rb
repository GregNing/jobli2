class Admin::ResumesController < ApplicationController
    before_action :authenticate_user!, only: [:index]    
    before_action :require_is_admin
    layout "admin"
    def index        
        @jobs = Job.find(params[:job_id]) 
        @resumes = @jobs.resumes.order('created_at DESC')
    end
end
