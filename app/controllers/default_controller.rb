class DefaultController < ApplicationController
  def index
      redirect_to "/family/index", :status=>303
      return
  end
end
