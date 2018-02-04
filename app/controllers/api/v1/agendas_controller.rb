module Api
  module V1
    class AgendasController < ApplicationController
      before_action :set_agenda, only: [:show, :update, :destroy]

      # GET /api/v1/agendas
      def index
        @agendas = Agenda.all
        
      end
    end
  end
end
