class Question < ApplicationRecord
  has_many :valuations;
  has_many :feedbacks;

  def as_json(options={})
    super(options).merge(
      valuation: valuations.last,
      feedback: feedbacks.last
    )
  end

end
