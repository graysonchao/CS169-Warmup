require 'spec_helper'

describe FlowController do

  describe "GET index" do
    it "renders the index" do
      get :index
      expect(response).to render_template("index")
    end
  end

end
