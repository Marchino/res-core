require 'spec_helper'

describe "EmailReader" do
  it "imports all unread emails" do
    expect{ ResCore::EmailReader.import_unread_emails! }.to change{ Review.count }.by 1
  end
end
