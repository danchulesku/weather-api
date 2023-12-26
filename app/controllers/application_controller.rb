class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :handle_exception
  before_action :check_api_status

  def handle_exception
    render json: { error: 'Record not found' }, status: :not_found
  end

  def check_api_status
    redis = Redis.new(url: Shared::Operations::HandleErrors::REDIS_URL)
    error = redis.get('api-error')
    render json: { error: }, status: :bad_request if error
  end
end
