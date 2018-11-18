class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper # 8.2 ログイン参照

end
