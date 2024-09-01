class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name avatar])
  end

  private

  def pagination_meta(collection)
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.prev_page,
      total_pages: collection.total_pages,
      total_count: collection.total_count
    }
  end

  def decode_base64_image(base64_image)
    content_type = base64_image[%r{data:(.*?);base64}, 1]
    encoded_image = base64_image.sub(%r{^data:.*;base64,}, '')
    decoded_image = Base64.decode64(encoded_image)
    {
      io: StringIO.new(decoded_image),
      filename: "upload-#{Time.now.to_i}.#{content_type.split('/').last}",
      content_type: content_type
    }
  end

  def format_errors(errors)
    errors.messages.transform_values { |messages| messages.join(', ') }
  end
end
