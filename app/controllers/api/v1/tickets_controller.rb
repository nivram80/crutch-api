module Api
  module V1
    class TicketsController < ApplicationController
      include ActionController::HttpAuthentication::Token::ControllerMethods
      include ActionController::ImplicitRender

      before_filter :restrict_access
      respond_to :json

      def index
        respond_with(Ticket.all.order("created_at DESC"))
      end

      def show
        respond_with(Ticket.find(params[:id]))
      end

      def create
        @ticket = Ticket.new(tickets_params)
        if @ticket.save
          respond_to do |format|
            format.json { render :json => @ticket }
          end
        end
      end

      def update
        @ticket = Ticket.find(params[:id])
        if @ticket.update(tickets_params)
          respond_to do |format|
            format.json { render :json => @ticket }
          end
        end
          end

      def destroy
        respond_with(Ticket.destroy(params[:id]))
      end

  private
      def tickets_params
        params.require(:ticket).permit(:title, :details, :priority)
      end

      def restrict_access
        authenticate_or_request_with_http_token do |token, options|
          ApiKey.exists?(access_token: token)
        end
      end

    end
  end
end