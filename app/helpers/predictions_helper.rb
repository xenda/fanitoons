module PredictionsHelper

  def team_predictions(prediction)
    
    local_goals = prediction.first_team_result || "--"
    visitor_goals = prediction.second_team_result || "--"
    
    local_text = "#{prediction.match.local.name} (#{local_goals})"
    visitor_text = "#{prediction.match.visitor.name} (#{visitor_goals})"

    local_class = ""
    local_class << "winner" if prediction.local_winner?
    
    visitor_class = ""
    visitor_class << "winner" if prediction.visitor_winner?
    
    content_tag(:td,local_text, :class=>local_class) + content_tag(:td,visitor_text,:class=>visitor_class)
    
  end

end