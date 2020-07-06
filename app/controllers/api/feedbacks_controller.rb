module Api
  class FeedbacksController < ApplicationController
    rescue_from ActionController::ParameterMissing do |e|
      render(json: e.message.to_json, status: :bad_request)
    end

    rescue_from do
      render(body: nil, status: :internal_server_error)
    end

    def create
      feedback = Feedback.new(create_feedback_params)
      if feedback.save
        head :created
      else
        render(json: feedback.errors.to_json, status: :bad_request)
      end
    end

    private

    def create_feedback_params
      { name: params.require(:name), comment: params.require(:comment) }
    end
  end
end
