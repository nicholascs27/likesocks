class SiteController < ApplicationController

  before_action :authenticate_usuario!
  layout "site"

end
