class RedirectController < ApplicationController
  skip_before_filter :decode_signed_request
  skip_before_filter :require_basic_information_permission
end
