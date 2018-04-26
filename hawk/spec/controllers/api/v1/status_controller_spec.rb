require "rails_helper"


RSpec.describe Api::V1::StatusController do

  context 'without a valid token' do
    before do
      @request.headers['Authorization'] = ""
      get 'index'
    end

    it 'returns a response with 401 status' do
      expect(response).to have_http_status 401
    end
  end



  context 'with a fake token' do
    before do
      @request.headers['Authorization'] = "Token token_string"
      get 'index'
    end

    it 'it returns a response with 401 status code' do
      expect(response).to have_http_status 401
    end
  end



  context 'with a valid token' do
    before do
      fake_yaml_store = YAML.load_file(file_fixture("api_token_dummy.store"))
      allow(File).to receive(:open).and_return(fake_yaml_store)
      @request.headers['Authorization'] = "Token a123456789"
      get 'index'
    end

    it 'it returns a response with 200 status code' do
      expect(response).to have_http_status 200
    end
  end

end
