module ResCore
  class EmailReader
    def self.import_unread_emails!
      Mail.find(keys: ['NOT', 'SEEN']).each do |email|
        Review.import_from_email email
      end
    end
  end
end
