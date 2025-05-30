class ChatAiController < ApplicationController
  before_action :authenticate_user!
  def index
    @question = params[:question]
    @answer = params[:answer]
    @chat = current_user.chats.find_by(question: @question, answer: @answer) if user_signed_in? && @question.present?
  end

  def ask
    if request.post?
      question = params[:question]&.strip
      @chat = current_user.chats.new(question: question) if user_signed_in?

      if question.blank? || (@chat && !@chat.valid?)
        flash[:alert] = @chat&.errors&.full_messages&.join(", ") || "Please enter a question."

        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.update("flash-messages", partial: "shared/flash")
          end

          format.html do
            redirect_to chat_ai_index_path
          end
        end

      else
        @answer = OpenrouterService.generate_answer(question) rescue "Error generating answer"
        @chat.answer = @answer
        @chat.save if user_signed_in?

        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.update("answer-container", partial: "answer", locals: { answer: @answer, chat: @chat })
          end

          format.html do
            render :index, locals: { question: question, answer: @answer, chat: @chat }
          end
        end
      end
    else
      redirect_to chat_ai_index_path(question: params[:question], answer: params[:answer])
    end
  end
end
