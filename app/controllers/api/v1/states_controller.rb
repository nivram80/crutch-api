module Api
  module V1
    class StatesController < ApplicationController
      include ActionController::HttpAuthentication::Token::ControllerMethods
      include ActionController::ImplicitRender

      before_filter :restrict_access
      respond_to :json

      def index
        respond_with(State.all.order("created_at DESC"))
      end

      def show
        respond_with(State.find(params[:id]))
      end

      def create
        @state = State.new(state_params)
        if @state.save
          respond_to do |format|
            format.json { render :json => @state }
          end
        end
      end

      def update
        @state = State.find(params[:id])
        if @state.update(state_params)
          respond_to do |format|
            format.json { render :json => @state }
          end
        end
      end

      def destroy
        respond_with(State.destroy(params[:id]))
      end

  private
      def state_params
        params.require(:state).permit(:title, :position)
      end

      def restrict_access
        authenticate_or_request_with_http_token do |token, options|
          ApiKey.exists?(access_token: token)
        end
      end

    end
  end
end