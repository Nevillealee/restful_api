module Api
  module V1
    class AgendasController < ApplicationController
      before_action :set_agenda, only: [:show, :update, :destroy]

      # GET /api/v1/agendas
      def index
        @agendas = Agenda.all
        #custom helper  function defined in controllers/concerns
        json_response(@agendas)
      end

      # POST /api/v1/agendas
      def create
        @agenda = Agenda.create!(agenda_params)
        json_response(@agenda, :created)
      end

      # GET /api/v1/agendas/:id
      def show
        json_response(@agenda)
      end

      # PUT /api/v1/agendas
      def update
        @agenda.update(agenda_params)
        # sends header only response
        head :no_content
      end

      # DELETE /api/v1/agendas
      def destroy
        @agenda.destroy
        head :no_content
      end

      private

      def agenda_params
        params.permit(:title, :created_by)
      end

      #set instance variable in before_action for class level scoping
      def set_agenda
        @agenda = Agenda.find(params[:id])
      end

    end
  end
end
