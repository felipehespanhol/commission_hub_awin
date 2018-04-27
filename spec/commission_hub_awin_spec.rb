require 'spec_helper'

describe CommissionHub do
  it 'has a version number' do
    expect(CommissionHub::Awin::VERSION).not_to be nil
  end

  describe CommissionHub::Awin::Settings do
    it 'has a base_uri' do
      expect(CommissionHub::Awin::Settings.new).to respond_to(:base_uri)
    end

    it 'has an api_token' do
      expect(CommissionHub::Awin::Settings.new).to respond_to(:api_token)
    end

    it 'has an publisher_id' do
      expect(CommissionHub::Awin::Settings.new).to respond_to(:publisher_id)
    end
  end

  describe CommissionHub::Awin::Connection do
    let(:base_uri)     { "https://api.awin.com" }
    let(:api_token)    { "KVBcCy1MgWli+Ui64v+6RenJspG1b8DXg7BeHFXf/yw=" }
    let(:publisher_id) { 10 }
    let(:connection)   { CommissionHub.initialize_connection(:awin) }

    before do
      eval <<~COMMISSION_HUB_SETUP
        CommissionHub.setup do |config|
          config.setup :awin do |c|
            c.base_uri     = "#{base_uri}"
            c.api_token    = "#{api_token}"
            c.publisher_id = "#{publisher_id}"
          end
        end
      COMMISSION_HUB_SETUP
    end

    describe '#advertisers' do
      let(:advertisers_url) { "#{base_uri}/publishers/#{publisher_id}/programmes" }

      before do
        stub_request(:get, advertisers_url).
          with(headers: { "Authorization" => "Bearer #{api_token}" }).
          to_return(status: 200, body: "", headers: {})
      end

      it 'calls for GET /publishers/:id/programmes' do
        connection.advertisers
        expect(a_request(:get, "https://api.awin.com/publishers/10/programmes")).
          to have_been_made
      end
    end
  end
end
