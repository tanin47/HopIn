class ErrorController < ApplicationController
  skip_before_filter :decode_signed_request

end
