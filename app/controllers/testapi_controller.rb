class TestapiController < ApplicationController
  
  def reset_fixture
    User.destroy_all
    render :json => { :errCode => 1 }
  end

  def unit_tests

    testresults = `rake test`
    
    splitresults = testresults.split("\n")[-1].split(", ")

    numtests = splitresults[0].split(" ")[0].to_i
    numfails = splitresults[2].split(" ")[0].to_i
    render :json => { :errCode => 1,
      :totalTests => numtests,
      :nrFailed => numfails,
      :output => testresults }
  end

end
