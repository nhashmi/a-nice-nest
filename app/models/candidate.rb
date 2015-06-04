class Candidate < ActiveRecord::Base
  belongs_to :user
  validates :zpid, uniqueness: { scope: :user_id }

  def bath_score(residents)
    bath_ratio = baths.to_f / residents
    if bath_ratio > 1
      5
    elsif bath_ratio == 1
      3
    else
      1
    end
  end

  def bed_score(residents)
    bed_ratio = beds.to_f / residents
    if bed_ratio > 1
      5
    elsif bed_ratio == 1
      3
    else
      1
    end
  end

  def size_score
    if size.to_i > 1500
      5
    elsif size.to_i > 1000
      3
    else
      1
    end
  end

  def public_transportation_score
    if public_transportation == '1'
      5
    else
      1
    end
  end

  def parking_score
    if parking == '1'
      5
    else
      1
    end
  end

  def bike_friendly_score
    if bike_friendly == '1'
      5
    else
      1
    end
  end

  def affordability(tenant_maximum)
    if total_rent.to_i > tenant_maximum
      self.score = 0
    else
      self.score *= tenant_maximum.to_f / total_rent.to_f
    end
  end

  def self.rank(current_user) # Rank each saved address
    # Default multiplier for a category is 1
    baths_multiplier = 1
    beds_multiplier = 1
    size_multiplier = 1
    bike_friendly_multiplier = 1
    parking_multiplier = 1
    public_transportation_multiplier = 1
    # Each category starts off with 0 points
    baths_points = 0
    beds_points = 0
    size_points = 0
    bike_friendly_points = 0
    parking_points = 0
    public_transportation_points = 0

    sum_rents = 0
    # Give a candidate points based on how its attributes
    # compare to each of the household member's rankings
    current_user.rankings.each do |ranking|
      baths_points += ranking.evaluate(ranking.own_baths)
      beds_points += ranking.evaluate(ranking.own_beds)
      size_points += ranking.evaluate(ranking.size)
      bike_friendly_points += ranking.evaluate(ranking.bike_friendly)
      parking_points += ranking.evaluate(ranking.parking)
      public_transportation_points += ranking.evaluate(ranking.public_transportation)
      sum_rents += ranking.max_rent
    end

    total_residents = current_user.rankings.length

    # Normalize multiplier by size of household
    baths_multiplier *= (baths_points.to_f / total_residents.to_f)
    beds_multiplier *= (beds_points.to_f / total_residents.to_f)
    size_multiplier *= (size_points.to_f / total_residents.to_f)
    bike_friendly_multiplier *= (bike_friendly_points.to_f / total_residents.to_f)
    parking_multiplier *= (parking_points.to_f / total_residents.to_f)
    public_transportation_multiplier *= (public_transportation_points.to_f / total_residents.to_f)

    # Calculate score (sum of (points * multiplier))
    current_user.candidates.each do |candidate|
      candidate.score =
        (
          candidate.bath_score(total_residents) * baths_multiplier +
          candidate.bed_score(total_residents) * beds_multiplier +
          candidate.size_score * size_multiplier +
          candidate.public_transportation_score * public_transportation_multiplier +
          candidate.bike_friendly_score * bike_friendly_multiplier +
          candidate.parking_score * parking_multiplier
        )

      candidate.affordability(sum_rents)
    end
    Candidate.sort_candidates(current_user, 30) # use 30 as the threshold
  end

  def self.sort_candidates(user, threshold)
    best_fit = user.candidates.max_by(&:score)
    ranked_candidates = {
      best_fit: best_fit,
      good_fits: user.candidates.select { |candidate| candidate.score > threshold && candidate != best_fit },
      poor_fits: user.candidates.reject { |candidate| candidate.score > threshold }
    }
    ranked_candidates
  end

  def render_checkbox_score(attribute)
    if attribute == '1'
      return 'Yes'
    else
      return 'No'
    end
  end
end
