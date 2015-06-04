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

    sum_rents = 0

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

    baths_multiplier *= (baths_points.to_f / total_residents.to_f)
    beds_multiplier *= (beds_points.to_f / total_residents.to_f)
    size_multiplier *= (size_points.to_f / total_residents.to_f)
    bike_friendly_multiplier *= (bike_friendly_points.to_f / total_residents.to_f)
    parking_multiplier *= (parking_points.to_f / total_residents.to_f)
    public_transportation_multiplier *= (public_transportation_points.to_f / total_residents.to_f)

    current_user.candidates.each do |candidate|
      # baths
      bath_ratio = candidate.baths.to_f / total_residents
      if bath_ratio > 1
        bath_score = 5
      elsif bath_ratio == 1
        bath_score = 3
      else
        bath_score = 1
      end

      # beds
      bed_ratio = candidate.beds.to_f / total_residents
      if bed_ratio > 1
        bed_score = 5
      elsif bed_ratio == 1
        bed_score = 3
      else
        bed_score = 1
      end

      # size
      if candidate.size.to_i > 1500
        size_score = 5
      elsif candidate.size.to_i > 1000
        size_score = 3
      else
        size_score = 1
      end

      # public_transportation (none, yes)
      public_transportation_score = candidate.quality(candidate.public_transportation)

      # bike_friendly (none, yes)
      bike_friendly_score = candidate.quality(candidate.bike_friendly)

      # parking (none, yes)
      parking_score = candidate.quality(candidate.parking)

      candidate.score =
        (
          bath_score * baths_multiplier +
          bed_score * beds_multiplier +
          size_score * size_multiplier +
          public_transportation_score * public_transportation_multiplier +
          bike_friendly_score * bike_friendly_multiplier +
          parking_score * parking_multiplier
        )

      if candidate.total_rent.to_i > sum_rents
        candidate.score = 0
      else
        candidate.score *= (1.0 / (candidate.total_rent.to_f / sum_rents.to_f))
      end
    end

    threshold = 30

    @best_fit = current_user.candidates.max_by(&:score)

    ranked_candidates = {
      best_fit: @best_fit,
      good_fits: current_user.candidates.select { |candidate| candidate.score > threshold && candidate != @best_fit },
      poor_fits: current_user.candidates.reject { |candidate| candidate.score > threshold }
    }

    return ranked_candidates
  end

  def quality(attribute)
    if attribute == 1
      return 5
    else
      return 1
    end
  end

  def render_checkbox_score(attribute)
    if attribute == "1"
      return 'Yes'
    else
      return 'No'
    end
  end
end
