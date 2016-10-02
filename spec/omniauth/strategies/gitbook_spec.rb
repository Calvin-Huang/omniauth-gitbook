require 'spec_helper'

describe OmniAuth::Strategies::GitBook do

  subject do
    OmniAuth::Strategies::GitBook.new({})
  end

  context 'client options' do
    it 'should have correct site' do
      subject.options.client_options.site.should eq('https://api.gitbook.com')
    end

    it 'should have correct authorize url' do
      subject.options.client_options.authorize_url.should eq('https://api.gitbook.com/oauth/authorize')
    end

    it 'should have correct request access token target' do
      subject.options.client_options.token_url.should eq('https://api.gitbook.com/oauth/access_token')
    end
  end

  # context 'request access params' do
  #   it 'should have response_type whether user set in config' do
  #     subject.options.authorize_params['request_type'].should eq('code')
  #   end
  # end
end