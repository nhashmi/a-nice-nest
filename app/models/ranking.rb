class Ranking < ActiveRecord::Base
  belongs_to :user

  def self.load_rankings(user)
    if user.rankings.all.length == 0
      total_residents = user.other_residents.to_i + 1
      total_residents.times do
        user.rankings.create
      end
      @rankings = user.rankings.all
      return @rankings
    end
  end

  def ever_updated?
    created_at == updated_at ? false : true
  end

  def update_message
    if ever_updated?
      return "Last updated at"
    else
      return "Incomplete"
    end
  end


  def welcome_message
    if resident_name == "A resident"
      return "What are you looking for in a home?"
    else
      return "#{resident_name}, what are you looking for in a home?"
    end
  end

end
