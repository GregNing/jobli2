class Admin::JobsController < ApplicationController
    before_action :authenticate_user!, only: [:new,:show,:create, :destroy,:edit,:update, :publish, :hide]
    before_action :find_jobs_id, only: [:show , :destroy,:edit,:update, :publish, :hide]
    before_action :require_is_admin
    layout "admin"
    def index
        @jobs = @jobs = Job.all.descbycreated.paginate(page: params[:page],per_page: 5)
    end
    def new
       @jobs = Job.new
    end
    def create
       @jobs = Job.new(jobs_params)
       @jobs.user = current_user
       if @jobs.save
           redirect_to admin_jobs_path, notice: "#{@jobs.title}新增成功"
       else
           render :new
       end
    end
    def show    
    end
    def edit       
    end
    def update
        if @jobs.update(jobs_params)
            redirect_to admin_jobs_path, notice: "#{@jobs.title}修改成功"
        else
            render :edit
        end
    end
    def destroy
        @jobs.destroy
        redirect_to admin_jobs_path, alert: "#{@jobs.title}刪除成功"
    end

    def publish
        @jobs.publish!        
        redirect_back fallback_location: admin_jobs_path ,notice: "#{@jobs.title}發布成功"
    end

    def hide
        @jobs.hide!
        flash[:warning] = "#{@jobs.title}隱藏成功"        
        redirect_back fallback_location: admin_jobs_path
    end
    private
    def find_jobs_id
        @jobs = Job.find(params[:id])
    end
    def jobs_params
        params.require(:job).permit(:title, :description, :wage_upper_bound, :wage_lower_bound,:contact_email,:is_hidden)
    end
end
