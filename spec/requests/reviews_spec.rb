require 'spec_helper'

describe "Reviews API" do
  before :each do
    @published_review = Review.create from: 'me@example.com', subject: 'Review #1', body: 'This is an awesome review', published: true
    @unpublished_review = Review.create from: 'me@example.com', subject: 'Review #2', body: 'This is a bad review', published: false
  end

  it "shows all reviews" do
    get '/reviews'
    json = JSON.parse response.body
    expect(json.length).to eq(2)
    expect(response).to be_success
  end

  it "shows published reviews if published=true" do
    get '/reviews?published=true'
    json = JSON.parse response.body
    expect(json.length).to eq(1)
    expect(response).to be_success
  end

  it "publishes a review" do
    put "/reviews/#{@unpublished_review.id}", params: { review: { published: 't' } }
    expect(response).to be_success
    review = JSON.parse response.body, symbolize_names: true
    expect(review[:published]).to eq(true)
  end

  it "unpublishes a review" do
    put "/reviews/#{@published_review.id}", params: { review: { published: 'f' } }
    expect(response).to be_success
    review = JSON.parse response.body, symbolize_names: true
    expect(review[:published]).to eq(false)
  end

  it "doesn't permit to update other attributes" do
    put "/reviews/#{@published_review.id}", params: { review: { from: 'some@email.com' } }
    expect(response).to be_success
    review = JSON.parse response.body, symbolize_names: true
    expect(review[:from]).to_not eq('some@email.com')
  end
end

