// Put your application scripts here
$(document).ready(function() {
  
	if (document.ie != true)	{
		$('#banner-cont').jCarouselLite({
			btnNext: '.next',
			btnPrev: '.prev',
			speed: 800,
			visible:1,
			circular: true,
			auto: 5000
		});	
	}  


  date = $("div.counter").attr("rel");

  var next_match = Date.parse(date);
    
  $('body.counter div.counter').countdown({
      until: next_match,
      layout: "<div class='day'><span>{dn}</span>días</div> "+
      "<div class='hour'><span>{hn}</span>horas</div>"+
      "<div class='minute'><span>{mn}</span>minutos</div>"+
      "<div class='second'><span>{sn}</span>segundos</div>" });
  
      // / .day
      // /   %span -
      // /   días
      // / .hour
      // /   %span -
      // /   horas
      // / .minute
      // /   %span -
      // /   minutos
      // / .second
      // /   %span -
      // /   segundos
      
  
  $("div.team a.small").css({'display':'block'});
  $(".hidden").hide();
  
  $("div.team a.small").click(function(){
    index = $("div.team a.small").index(this);
    $(".team div.goals:eq(" + index + ")").show()
    return false;
  });
  
  $(".goals.hidden .small_close_button").click(function(){
    
    $(this).parent().hide();
    $(this).parent().find("select.goals").val("");
    return false;
    
  });
  
  $(".team").hover(function(){
    
      $(".team").removeClass("active");
      $(this).addClass("active");
    
  },function(){

    $(".team").removeClass("active");
    $(this).removeClass("active");
  
  
  })
  
  // Updates who's the winner'
  $(".team").click(function(){
    
    $(".team").removeClass("selected");
    $(this).addClass("selected");    
    
    $("#prediction_winner_id").val($(this).attr("rel"));
    
  })

  $("select.goals").click(function(){
    
    return false;
    
  })
  
  $("select.goals").change(function(){

    $(".team").removeClass("selected");    
    local = parseInt($("#prediction_first_team_result").val());
    visitor = parseInt($("#prediction_second_team_result").val());
    
    if (local > visitor ){
      selectTeam("#first_team.team");
    }
    if (local < visitor){
      
      selectTeam("#second_team.team");
    }
    if (local == visitor) {
      
      $("#prediction_winner_id").val("0");
      
    }
    
  })
  
  
  // Actives popup
  $("a.iframe").fancybox({
  		'transitionIn'	:	'elastic',
  		'transitionOut'	:	'elastic',
  		'speedIn'		:	100, 
  		'speedOut'		:	100,
  		'padding' : 0,
      // 'modal'  : true,
  		'hideOnOverlayClick': true, 
  		'hideOnContentClick': true,
  		'enableEscapeButton':true,
  		'scrolling' :false,
  		'centerOnScroll':true,
  		'width': 600,
  		'height': 340
  	});
  
  
});

function selectTeam(team){
  
  $(".team").removeClass("selected");
  $(team).addClass("selected")
  $("#prediction_winner_id").val($(team).attr("rel"));
  
  
}
