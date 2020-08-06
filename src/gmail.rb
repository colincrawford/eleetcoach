require "net/smtp"

class GMail
  def initialize(logger:, email:, password:)
    @email = email
    @password = password
    @smtp = Net::SMTP.new "smtp.gmail.com", 587
    @smtp.enable_starttls
  end

  def send_text(to, subject, content)
    send(to, text_content(to, subject, content))
  end

  def send_html(to, subject, content)
    send(to, html_content(to, subject, content))
  end

  private

  def send(to, email)
    @smtp.start("gmail.com", @email, @password, :plain) do |smtp|
      smtp.send_message(email, @email, to)
    end
  end

  def text_content(to, subject, content)
      <<~HTML
        From: #{@email}
        To: #{to}
        Subject: #{subject}

        #{content}
      HTML
  end

  def html_content(to, subject, content)
      <<~HTML
        From: #{@email}
        To: #{to}
        Subject: #{subject}
        MIME-Version: 1.0
        Content-type: text/html

        #{content}
      HTML
  end
end
