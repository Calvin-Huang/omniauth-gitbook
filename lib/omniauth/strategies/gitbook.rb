require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class GitBook < OmniAuth::Strategies::OAuth2
      base_url = 'https://api.gitbook.com'

      option :client_options, {
          site: base_url,
          authorize_url: "#{base_url}/oauth/authorize",
          token_url: "#{base_url}/oauth/access_token",
      }

      option :token_params, {
          grant_type: 'authorization_code'
      }

      uid { raw_info['id'].to_s }

      info do
        {
            'username' => raw_info['username'],
            'name' => raw_info['name'],
            'website' => raw_info['website'],
            'urls' => raw_info['urls'],
            'auth' => raw_info['auth'],
            'token' => raw_info['token'],
        }
      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        access_token.options[:mode] = :query
        @raw_info ||= access_token.get('account').parsed
      end

      def authorize_params
        super.tap do |params|
          %w[response_type].each do |v|
            params[v.to_sym] = 'code'
          end
        end
      end

      def request_phase
        super
      end
    end
  end
end

OmniAuth.config.add_camelization 'gitbook', 'GitBook'