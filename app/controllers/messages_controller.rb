class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    if @message.valid?
      UserMailer.contact_us(@message).deliver
      redirect_to root_url, notice: "Message sent! Thanks for your feedback!"
    else
      render "new"
    end
  end
end
