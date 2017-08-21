require 'mail'

Mail.defaults do
  retriever_method :imap, :address    => ENV['MAIL_ADDRESS'],
                          :port       => ENV['MAIL_PORT'],
                          :user_name  => ENV['MAIL_USER_NAME'],
                          :password   => ENV['MAIL_PASSWORD'],
                          :enable_ssl => (ENV['MAIL_ENABLE_SSL'] == 'true')
end
