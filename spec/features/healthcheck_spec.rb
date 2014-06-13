require 'spec_helper'

describe "Healthcheck page" do

  it "should return OK" do
    visit "/healthcheck"
    expect(page).to have_text("OK")
  end

end
