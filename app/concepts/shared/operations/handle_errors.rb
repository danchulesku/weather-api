module Shared
  module Operations
    class HandleErrors < Trailblazer::Operation
      step :handle_errors

      private

      def handle_errors(ctx, _params)
        redis = Redis.new(url: Rails.application.config.redis_url)
        redis.set('api-error', "#{ctx[:error]}. Change api key and restart app")
      end
    end
  end
end
