class JobsController < ApplicationController
   before_action :authenticate_user!, only: [:new,:show,:create, :destroy,:edit,:update]

    def index
       @jobs = Job.all.descbycreated.paginate(page: params[:page],per_page: 5)
    end 
end
