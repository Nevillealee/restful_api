#require(string) loads file once
#versus load 'filename'
#which loads each time method is executed
require 'rails_helper'

RSpec.describe 'Agendas API', type: :request do
  # intialize test data
  let!(:agendas) {create_list(:agenda, 10)}
  let(:agenda_id) {agendas.first.id}

  # Test suite for GET/agendas
  describe 'GET/api/v1/agendas' do
    #make HTTP get request prior to each example using before hook
    before {get '/api/v1/agendas'}

    it 'returns agendas' do
      #use custom helper function to parse JSON  responses 'json'
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /agendas/:id
  describe 'GET /api/v1/agendas/:id' do
    before {get "/api/v1/agendas/#{agenda_id}"}

    context 'when the record exists' do
      it 'returns the agenda' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(agenda_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when record doesnt exist' do
      let(:agenda_id) {100}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Agenda/)
      end
    end
  end

  # Test suite for POST /agendas
  describe 'POST /api/v1/agendas' do
    #valid payload
    let(:valid_attributes) {{ title: 'Learn React', created_by: '1'}}

    context 'when the request is valid' do
      before {post '/api/v1/agendas', params: valid_attributes}

      it 'creates an agenda' do
        expect(json['title']).to eq('Learn React')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before {post '/api/v1/agendas', params: {title: 'Laguna Nigel 5k'}}

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
        .to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  # Test suite for PUT /agendas/:id
  describe 'PUT /api/v1/agendas/:id' do
    let(:valid_attributes) {{title: 'Studying'}}

    context 'when record exists' do
      before {put "/api/v1/agendas/#{agenda_id}", params: valid_attributes}

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /agendas/:id
  describe 'DELETE /api/v1/agendas/:id' do
    before {delete "/api/v1/agendas/#{agenda_id}"}

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
