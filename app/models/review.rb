class Review < ActiveRecord::Base
  def self.import_from_email email
    review_body = email.multipart? ? email.parts[0].body : email.body
    create  from: email.from.join('; '),
            subject: email.subject,
            body: ActionController::Base.helpers.strip_tags(review_body.to_s)
  end
end
