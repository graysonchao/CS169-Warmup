class TestapiController < ApplicationController
  before_filter :ensure_json_request
  
  def reset_fixture
    User.destroy_all
    render :json => { "errCode" => 1 }
  end

  def unit_tests
    render status: :ok, json: { "errCode" => 1 }
  end

end
