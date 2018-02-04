module Api
  module V1
    class ItemsController < ApplicationController
      before_action :set_agenda
      before_action :set_agenda_item, only: [:show, :update, :destroy]

      # GET /api/v1/agendas/:agenda_id/items
      def index
        json_response(@agenda.items)
      end

      #GET /api/v1/agendas/:agenda_id/items/:id
      def show
        json_response(@item)
      end

      # POST /api/v1/agendas/:agenda_id/items
      def create
        @agenda.items.create!(item_params)
        json_response(@agenda, :created)
      end

      # PUT /api/v1/agendas/:agenda_id/items/:id
      def update
        @item.update(item_params)
        head :no_content
      end

      # DELETE /api/v1/agendas/:agenda_id/items/:id
      def destroy
        @item.destroy
        head :no_content
      end

      private

      def item_params
        params.permit(:name, :done)
      end
      #grab agenda_id param from  url
      def set_agenda
        @agenda = Agenda.find(params[:agenda_id])
      end
      #query agenda object created with set_agenda method above for item
      def set_agenda_item
        @item = @agenda.items.find_by!(id: params[:id]) if @agenda
      end
    end
  end
end
