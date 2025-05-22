class ChatAiController < ApplicationController
  def index
    @question = params[:question] || flash[:question]
    @answer = params[:answer] || flash[:answer]
  end

  def ask
    if request.post?
      question = params[:question]
      @answer = begin
        OpenrouterService.generate_answer(question)
      rescue => e
        "Error generating answer: #{e.message}"
      end

      respond_to do |format|
        format.turbo_stream # This renders ask.turbo_stream.erb

        format.html do
          render :index, locals: { question: question, answer: @answer }
        end
      end
    else
      redirect_to chat_ai_index_path(question: params[:question], answer: params[:answer])
    end
  end
  # puts "Question submitted: #{question}"
  # puts "Parsed answer: #{@answer.inspect}"
end
