require 'acceptance_helper'

module V1
  describe 'Datasets Meta', type: :request do
    context 'Create and delete dataset' do
      fixtures :datasets

      let!(:dataset_id) { Dataset.first.id }

      let!(:params) {{"connector": {"id": "9b98340b-5f51-444a-bed7-2c5bf7a1894c",
                      "connector_url": "https://rschumann.cartodb.com/api/v2/sql?q=select%20*%20from%20public.carts_test_endoint",
                      "attributes_path": "fields"
                    }}}

      let!(:params_failed) {{"connector": {"id": "9b98340b-5f51-444a-bed7-2c5bf7a1894b",
                             "connector_url": "https://rschumann.cartodb.com/api/v2/sql?q=select%20*%20from%20public.carts_test_endoin",
                             "attributes_path": "fields"
                            }}}

      it 'Allows access cartoDB data and save data attributes to db' do
        post "/datasets", params: params

        expect(status).to eq(201)
        expect(json['success']).to eq(true)
        expect(Dataset.find('9b98340b-5f51-444a-bed7-2c5bf7a1894c').data_columns).to be_present
      end

      it 'If dataset_url failed' do
        post "/datasets", params: params_failed

        expect(status).to eq(422)
        expect(json['success']).to eq(false)
        expect(Dataset.where(id: '9b98340b-5f51-444a-bed7-2c5bf7a1894b')).to be_empty
      end

      it 'Allows to delete dataset' do
        delete "/datasets/#{dataset_id}"

        expect(status).to eq(200)
        expect(json['message']).to eq('Dataset deleted')
        expect(Dataset.where(id: dataset_id)).to be_empty
      end
    end
  end
end
