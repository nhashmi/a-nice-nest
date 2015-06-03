class Candidate < ActiveRecord::Base
  belongs_to :user
  validates :zpid, uniqueness: { scope: :user_id }

  def self.rank(current_user)
    baths_multiplier = 1
    baths_points = 0
    beds_multiplier = 1
    beds_points = 0
    size_multiplier = 1
    size_points = 0
    bike_friendly_multiplier = 1
    bike_friendly_points = 0
    parking_multiplier = 1
    parking_points = 0
    public_transportation_multiplier = 1
    public_transportation_points = 0
    current_user.rankings.each do |ranking|
      baths_points += ranking.evaluate(ranking.own_baths)
      beds_points += ranking.evaluate(ranking.own_beds)
      size_points += ranking.evaluate(ranking.size)
      bike_friendly_points += ranking.evaluate(ranking.bike_friendly)
      parking_points += ranking.evaluate(ranking.parking)
      public_transportation_points += ranking.evaluate(ranking.public_transportation)
    end
    total_residents = current_user.rankings.length
    baths_multiplier *= (baths_points.to_f / total_residents.to_f)
    beds_multiplier *= (beds_points.to_f / total_residents.to_f)
    size_multiplier *= (size_points.to_f / total_residents.to_f)
    bike_friendly_multiplier *= (bike_friendly_points.to_f / total_residents.to_f)
    parking_multiplier *= (parking_points.to_f / total_residents.to_f)
    public_transportation_multiplier *= (public_transportation_points.to_f / total_residents.to_f)
    binding.pry
  end

  # Calculate per-person-thresholds from current_user.rankings
      # priority_score = fn(each person's rankings)
      # default priority_score is 1
      #
    # Sort each candidate into best fit, good fits, and poor fits
      # For each category:
      # priority_score * fit && total_rent <= sum of max_rent
      # if ranking is low priority, give 1 point
      # if ranking is medium priority, give 3 points for candidate that fits
      # if ranking is high priority, give 5 points for candidate that fits

  # Return a hash:
  # ranked_candidates: {
  #  best_fit: #candidate,
  #  good_fits: [#candidate, #candidate]
  #  poor_fits: [#candidate, #candidate]
  # }

end
