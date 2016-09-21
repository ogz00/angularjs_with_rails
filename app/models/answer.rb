class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :puzzle

  def as_json(options = {})
    super(options.merge({ except: [:answer_orginal, :success, :updated_at, :created_at] }))
  end


end
