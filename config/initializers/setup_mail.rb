ActionMailer::Base.smtp_settings = { 
  :address => 'fenix.fisica.unam.mx',
  :port => 25,
  :domain => 'fisica.unam.mx',
  :location       => '/usr/sbin/sendmail',
  :arguments      => '-i -t -f noreply@fisica.unam.mx'
}
