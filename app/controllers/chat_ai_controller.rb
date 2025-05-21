class ChatAiController < ApplicationController
  def index
    @question = flash[:question]
    @answer = flash[:answer]
  end

  def ask
    @answer = OpenrouterService.generate_answer(params[:question])
    # @question = params[:question]
    # @answer = OpenrouterService.generate_answer(@question)

    respond_to do |format|
      format.html do
        flash[:question] = @question
        flash[:answer] = @answer
        redirect_to chat_ai_index_path
      end

      format.turbo_stream # This will render ask.turbo_stream.erb if using Turbo
    end

    puts "Question submitted: #{@question}"
    puts "Parsed answer: #{@answer.inspect}"
  end
end
