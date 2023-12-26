class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :handle_exception

  def handle_exception
    render json: { error: 'Record not found' }, status: :not_found
  end
end
