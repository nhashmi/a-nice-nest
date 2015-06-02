class Ranking < ActiveRecord::Base
  belongs_to :resident

  def self.load_residents_and_rankings(user)
    if user.rankings.all.length == 0
      total_residents = user.other_residents.to_i + 1
      total_residents.times do
        new_resident = user.residents.create(name: 'A resident')
        new_resident.rankings.create
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
      return "last updated #{updated_at.time_ago_in_words}"
    else
      return "incomplete"
    end
  end

end
