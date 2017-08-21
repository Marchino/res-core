class Review < ActiveRecord::Base
  def self.import_from_email email
    review_body = (email.multipart? ? email.parts[0].body : email.body).decoded
    score = ResCore::ToneAnalyzer.new.calculate_score(review_body)
    create  from: email.from.join('; '),
            subject: email.subject,
            body: ActionController::Base.helpers.strip_tags(review_body),
            score: score,
            sent_at: email.date.in_time_zone('GMT')
  end
end
