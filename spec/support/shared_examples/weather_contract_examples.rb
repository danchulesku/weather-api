RSpec.shared_examples 'weather contract' do
  subject { operation.send(:validate, ctx, params) }

  context 'WHEN params are valid' do
    let(:params) { { city_code: 'code', api_domain: 'domain', api_key: 'key' } }

    it { is_expected.to be_truthy }
  end

  context 'WHEN params are invalid' do
    let(:params) { { city_code: nil, api_domain: 'domain', api_key: 'key' } }

    it { is_expected.to be false }
  end
end
