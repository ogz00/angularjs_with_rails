class UserMailer < ActionMailer::Base
  default from: "oguzhan@halici.com.tr"

  def result_email(user_id)
    @user = User.find(user_id)
    mail(to: @user.email)
  end

  def info_email(user_id, email_subject, email_body)
    mail(from:"info@tzg.org.tr",
         to: "oguzhan@halici.com.tr",
         body: email_body,
         content_type: "text/html",
         subject: email_subject)
  end
end
