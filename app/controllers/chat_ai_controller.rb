class ChatAiController < ApplicationController
  before_action :authenticate_user!
  def index
    @question = params[:question] || flash[:question]
    @answer = params[:answer] || flash[:answer]
    @chat = current_user.chats.find_by(question: @question, answer: @answer) if user_signed_in? && @question.present?
  end

  def ask
    if request.post?
      question = params[:question]
      @answer = OpenrouterService.generate_answer(question) rescue "Error generating answer"

      @chat = current_user.chats.create(question: question, answer: @answer) if user_signed_in?

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("answer-container", partial: "answer",
            locals: { answer: @answer, chat: @chat })
        end

        format.html do
          render :index, locals: { question: question, answer: @answer, chat: @chat }
        end
      end
    else
      redirect_to chat_ai_index_path(question: params[:question], answer: params[:answer])
    end
  end
end
