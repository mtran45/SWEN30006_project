require 'mandrill'

class EmailController < ApplicationController
  def create
    @articles = Article.tagged_with(current_user.interest_list, :any =>true).order(:pub_date).to_a
    @user = current_user
    @history = MailRecording.where(email: @user.email)
    count = 0

    #This is source formatter 
    html = "<h1>This is new digest</h1>"
    @articles.each do |article|
      if !@history.exists?(articlename: article.title)
        if count < 10
          html = html + "<div class='panel panel-default'>"
          html = html + "<div class='panel-body'>"
          html = html + "<h2>Title:</h2><h2>" + article.title + "</h2>"
          html = html + "<h3>Public Date:" + article.pub_date.strftime("%Y %m %d") + "</h3>"
          if article.images
              html = html + "<img src=" + article.images + " style= 'width:160px;height:100px';>" 
          end
          html = html + "<h4>" + article.summary + "</h4>"
          html = html + "</div></div>"
          count += 1


          record = MailRecording.new(email: @user.email ,articlename: article.title)
          record.save
        end
      end
    end    
    
    #This is email formatter
  	mandrill = Mandrill::API.new 'FW0LswnpFAVZLncd5rVfjw'
  	message = {"from_email"=>"noreply@thedigest.com",  
  			   "to"=>
           		[{"email" => ""}],
           		"subject": "Sending a text email from the Mandrill API",
           		"from_name"=>"New Digest",
           		"html": ""
  				}

    message["to"][0]["email"] = @user.email

    if count == 0
      message["html"] = "<h2>There is no more new articles</h2>"
    else    
      message["html"] = html
    end
    #send email function
    result = mandrill.messages.send message
    redirect_to :articles
    
    #This is exception checking
    rescue Mandrill::Error => e
    # Mandrill errors are thrown as exceptions
    puts "A mandrill error occurred: #{e.class} - #{e.message}"
    # A mandrill error occurred: Mandrill::UnknownSubaccountError - No subaccount exists with the id 'customer-123'    
    raise
    
  end

end
