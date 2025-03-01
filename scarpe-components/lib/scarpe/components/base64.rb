# frozen_string_literal: true

require "base64"
require "uri"

class Scarpe; end
module Scarpe::Components; end
class Scarpe
  module Components::Base64
    def valid_url?(string)
      uri = URI.parse(string)
      uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
    rescue URI::InvalidURIError, URI::BadURIError
      false
    end

    def encode_file_to_base64(image_filename)
      directory_path = File.dirname(__FILE__, 5)

      image_path = File.join(directory_path, image_filename)

      image_data = File.binread(image_path)

      encoded_data = ::Base64.strict_encode64(image_data)

      encoded_data
    end
  end
end
