module Shared
  module Operations
    class HandleErrors < Trailblazer::Operation
      step :handle_errors

      REDIS_URL = 'redis://localhost:6379'

      private

      def handle_errors(ctx, _params)
        redis = Redis.new(url: REDIS_URL)
        redis.set('api-error', ctx[:error])
      end
    end
  end
end
