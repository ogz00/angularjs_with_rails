class Puzzle < ActiveRecord::Base

  has_many :comments, :dependent => :delete_all

  def as_json(options = {})
    super(options.merge({ except: [:answer, :timestamp, :updated_at, :created_at, :isTabled] }))
  end
end
