require 'spec_helper'

describe "Review" do
  let(:email_params){
    { to: 'support@example.com',
      from: 'me@example.com',
      subject: 'product review',
      body: 'this product is good',
      date: '2017-01-01 12:12:00 GMT'.to_time,
      message_id: SecureRandom.uuid }
  }
  
  it "can be imported from an email object" do
    email = Mail.new email_params
    expect{ Review.import_from_email email }.to change{ Review.count }.by 1
    review = Review.last
    expect(review.from).to eq(email_params[:from])
    expect(review.subject).to eq(email_params[:subject])
    expect(review.body).to eq(email_params[:body])
    expect(review.sent_at).to eq(email_params[:date])
  end

  it "doesn't import the same email again" do
    email = Mail.new email_params
    Review.import_from_email email
    expect{ Review.import_from_email email }.to change{ Review.count }.by 0
  end

  it "strips out html from mail body" do
    email_params[:body] = '<p>This product is <b>good</b></p>'
    email = Mail.new email_params
    review = Review.import_from_email email
    expect(review.body).to eq('This product is good')
  end

  it "imports from multipart email" do
    email = Mail.new do
      to      'support@example.com'
      from    'Mikel Lindsaar <mikel@test.lindsaar.net.au>'
      date    '2017-01-01 12:12:00 GMT'
      subject 'Review email'

      text_part do
        body 'This product is VERY GOOD'
      end

      html_part do
        content_type 'text/html; charset=UTF-8'
        body '<p>This product is <b>VERY GOOD</b></p>'
      end
    end
    review = Review.import_from_email email
    expect(review.body).to eq('This product is VERY GOOD')
  end

  it "assigns a score to the review when imported" do
    email = Mail.new email_params
    review = Review.import_from_email email
    expect(review.score).to eq(100)
  end

end
