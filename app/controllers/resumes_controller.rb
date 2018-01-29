class ResumesController < ApplicationController
    before_action :authenticate_user!
    def new
        @jobs = Job.find(params[:job_id])
        @resumes = Resume.new
    end
    def create        
        @jobs = Job.find(params[:job_id])
        @resumes = Resume.new(resumes_params)         
        @resumes.job = @jobs
        @resumes.user = current_user
        if @resumes.save
            redirect_to job_path(@jobs), notice: "#{@jobs.title}提交履歷成功"
        else
            render :new
        end
    end
    private
    def resumes_params
        params.require(:resume).permit(:content,:attachment)
    end
end
