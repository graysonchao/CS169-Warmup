# Handles TESTAPI calls.
class TestapiController < ApplicationController
  
  def reset_fixture
    User.destroy_all
    render :json => { :errCode => 1 }
  end

  def unit_tests

    # Backticks return the output of the command inside
    testresults = `rake spec`
    splitresults = testresults.split("\n")[-3].split(", ")

    numtests = splitresults[0].split(" ")[0].to_i
    numfails = splitresults[1].split(" ")[0].to_i
    render :json => { :errCode => 1,
      :totalTests => numtests,
      :nrFailed => numfails,
      :output => testresults }
  end

end
