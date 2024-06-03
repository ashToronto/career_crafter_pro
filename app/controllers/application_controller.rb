class ApplicationController < ActionController::Base
  rescue_from StandardError, with: :standard_error_logger
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_logger
  rescue_from ActiveRecord::RecordInvalid, with: :handle_validation_failure

  private

  def standard_error_logger(e)
    logger.error "Something went wrong StandardError raised: #{e.message}"
    redirect_to error_path, alert: e.message
  end

  def record_not_found_logger(e)
    logger.error "Something went wrong Record not found: #{e.message}"
    redirect_to error_path, alert: e.message
  end

  def handle_validation_failure(e)
    logger.error "Validation failed: #{e.message}"
    redirect_to request.referrer || error_path, alert: "Validation failed: #{e.record.errors.full_messages.join(', ')}"
  end
end
