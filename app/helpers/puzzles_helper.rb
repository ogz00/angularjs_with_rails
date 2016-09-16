module PuzzlesHelper

  require 'date'

  def self.current
    year = Time.now.year
    now = DateTime.now
    Puzzle
        .where('year = ?', year)
        .where('publish = ?', true)
        .where('publish_date < ?', now)
        .order('no DESC')
  end


end
