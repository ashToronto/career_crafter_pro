class ApplicationController < ActionController::Base
  rescue_from StandardError, with: :standard_error_logger
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_logger

  private

  def standard_error_logger(e)
    logger.error "Something went wrong StandardError raised: #{e.message}"
    redirect_to error_path, alert: e.message
  end

  def record_not_found_logger
    logger.error "Something went wrong Record not found: #{e.message}"
    redirect_to error_path, alert: e.message
  end
end
