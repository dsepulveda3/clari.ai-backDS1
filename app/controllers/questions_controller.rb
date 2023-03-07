require 'openai'
class QuestionsController < ApplicationController

  def index
    @questions = Question.order(id: :desc).paginate(page: params[:page], per_page: params[:entries]) 
    render json: @questions.to_json()
  end

  def create
    question = Question.create(content: params[:content])
    lang = params[:lang]
    pre_prompt_es = "Si es un ejercicio de matematicas o fisica explique como resolverlo teoricamente, pongame un ejemplo y luego resuelva el ejemplo y la pregunta paso a paso.
    De lo contrario, si es una pregunta conceptual, explique en términos simples, detallados, definiendo primero los conceptos difíciles que se utilizarán en la explicación."
    #pre_prompt_en = "Answer the following question, with an explanation easy for a student to understand:"
    pre_prompt_en = "If this is a math or physics exercise explain how to solve it theoretically, give me an example and then solve the example and the question step by step.
    Otherwise, if it is a conceptual question explain in simple terms, detailed, first defining difficult concepts that will be used in the explanation."
    final_prompt = lang == "es" ? pre_prompt_es : pre_prompt_en
    prompt = final_prompt + params[:content]
    openai_client = OpenAI::Client.new(api_key: ENV["API_KEY"], default_engine: "text-davinci-003")
    r = openai_client.completions(
      prompt: prompt,
      max_tokens: 1500,
      temperature: 0.5,
      n: 1,
    )
    puts("Heeey there")
    question.update(answer: r[:choices][0][:text].lstrip)
    render json: {info: question, status: :success}
  end

  def test
    openai_client = OpenAI::Client.new(api_key: ENV["API_KEY"], default_engine: "ada")
    render json: {status: :success}
  end

  def like
    question = Question.find(params[:id])
    #puts("Hete comes the params")
    #puts(params)

    valuation = Valuation.create(question: question, is_positive: true)
    render json: {info: question, status: :success}
  end

  def dislike
    question = Question.find(params[:id])
    valuation = Valuation.create(question: question, is_positive: false)
    render json: {info: question, status: :success}
  end

  def feedback
    question = Question.find(params[:id])
    #puts("Here comes params from FEEDBACK")
    #puts(params)
    content = params[:feedback]
    feedback = Feedback.create(question: question, feedback: content)
    render json: {info: question, status: :success}
    # given_feedback = Feedback.create(question: question, feedback: feed)
  end
end
