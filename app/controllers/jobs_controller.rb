class JobsController < ApplicationController
    before_action :authenticate_user!, only: [:new,:show,:create, :destroy,:edit,:update]
    before_action :find_jobs_id, only: [:show , :destroy,:edit,:update]
    def index
        @jobs = case params[:order]
                when 'by_lower_bound'
                @jobs = Job.all.published.descbywage_lower_bound.paginate(page: params[:page],per_page: 5)
                when 'by_upper_bound'
                @jobs = Job.all.published.descbywage_upper_bound.paginate(page: params[:page],per_page: 5)
                else
                @jobs = Job.all.published.descbycreated.paginate(page: params[:page],per_page: 5)
                end
       
    end
    def new
       @jobs = Job.new
    end
    def create
       @jobs = Job.new(jobs_params)
       @jobs.user = current_user
       if @jobs.save
           redirect_to jobs_path, notice: "#{@jobs.title}新增成功"
       else
           render :new
       end
    end
    def show    

    if @jobs.is_hidden
      flash[:warning] = "This Job already archived"
      redirect_to root_path
    end
    end
    def edit       
    end
    def update
        if @jobs.update(jobs_params)
            redirect_to jobs_path, notice: "#{@jobs.title}修改成功"
        else
            render :edit
        end
    end
    def destroy
        @jobs.destroy
        redirect_to jobs_path, alert: "#{@jobs.title}刪除成功"
    end
    private
    def find_jobs_id
        @jobs = Job.find(params[:id])
    end
    def jobs_params
        params.require(:job).permit(:title, :description, :wage_upper_bound, :wage_lower_bound,:contact_email)
    end
end
