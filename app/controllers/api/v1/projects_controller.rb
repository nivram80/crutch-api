module Api
  module V1
    class ProjectsController < ApplicationController
      include ActionController::HttpAuthentication::Token::ControllerMethods
      include ActionController::ImplicitRender

      before_filter :restrict_access
      respond_to :json

      def index
        respond_with(Project.all.order("created_at DESC"))
      end

      def show
        respond_with(Project.find(params[:id]))
      end

      def create
        @project = Project.new(project_params)
        if @project.save
          respond_to do |format|
            format.json { render :json => @project }
          end
        end
      end

      def update
        @project = Project.find(params[:id])
        if @project.update(project_params)
          respond_to do |format|
            format.json { render :json => @project }
          end
        end
      end

      def destroy
        respond_with(Project.destroy(params[:id]))
      end

  private
      def project_params
        params.require(:project).permit(:title)
      end

      def restrict_access
        authenticate_or_request_with_http_token do |token, options|
          ApiKey.exists?(access_token: token)
        end
      end

    end
  end
end