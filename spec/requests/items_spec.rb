require 'rails_helper'

RSpec.describe 'Items API' do
  #intialize the test data
  let!(:agenda) { create(:agenda) }
  let!(:items) { create_list(:item, 20, agenda_id: agenda.id) }
  let(:agenda_id) { agenda.id }
  let(:id) { items.first.id }

  # Test suite for GET /api/v1/agendas/:agenda_id/items
  describe 'GET /api/v1/agendas/:agenda_id/items' do
    before {get "/api/v1/agendas/#{agenda_id}/items"}

    context 'when agenda exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all agenda items' do
        expect(json.size).to eq(20)
      end
    end

    context 'when agenda does not exist' do
      let(:agenda_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns not found message' do
        expect(response.body).to match(/Couldn't find Agenda/)
      end
    end
  end

  # Test suite for GET /api/v1/agendas/:agenda_id/items/:id
  describe 'GET /api/v1/agendas/:agenda_id/items/id' do
    before {get "/api/v1/agendas/#{agenda_id}/items/#{id}"}

    context 'when agenda item exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the item' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  # Test suite for POST /api/v1/agendas/:agenda_id/items
  describe 'POST /api/v1/agendas/:agenda_id/items' do
    let(:valid_attributes) { {name: 'Run Mararthon', done: false} }

    context 'when request attributes are valid' do
      before {post "/api/v1/agendas/#{agenda_id}/items", params: valid_attributes}

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before {post "/api/v1/agendas/#{agenda_id}/items", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /api/v1/agendas/:agenda_id/items/:id

  describe 'PUT /api/v1/agendas/:agenda_id/items/:id' do
    let(:valid_attributes) { {name: 'Tim'} }

    before { put "/api/v1/agendas/#{agenda_id}/items/#{id}", params: valid_attributes }

    context 'when item exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the item' do
        updated_item = Item.find(id)
        expect(updated_item.name).to match(/Tim/)
      end
    end

    context 'when the item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  # Test suite for DELETE /api/v1/agendas/:id
  describe 'DELETE /api/v1/agendas/:id' do
    before { delete "/api/v1/agendas/#{agenda_id}/items/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
