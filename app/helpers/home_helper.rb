# Helper methods defined here can be accessed in any controller or view in the application

module HomeHelper
  
  def random_flag
    rand(10) > 5 ? "flag1.png" : "flag2.png"
  end
    
end