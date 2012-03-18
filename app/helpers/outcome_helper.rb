module OutcomeHelper

  def outcome_string(outcome)
    if outcome=="TIE"
      "TIE"
    else
      (outcome + " won!")
    end

  end

end
