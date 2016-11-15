class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    
    def create
       @micropost =  current_user.microposts.build(micropost_params)
       if @micropost.save
           flash[:success] = "Micropost created!"
           redirect_to root_url
       else
           flash[:danger] = 'This Micropost is required'
           @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
           redirect_to root_path
       end
    end
    
    def destroy
        @micropost = current_user.microposts.find_by(id: params[:id])
        return redirect_to root_url if @micropost.nil?
        @micropost.destroy
        flash[:success] = "Micropost delete"
        redirect_to request.referrer || root_url
    end
    
    private
    def micropost_params
       params.require(:micropost).permit(:content, :picture) 
    end
end
