module ProfileHelper
  
  def account_age
    if @account.birth_date
      distance_of_time_in_words_to_now(@account.birth_date)
    else
      "0 años"
    end
  end
  
end