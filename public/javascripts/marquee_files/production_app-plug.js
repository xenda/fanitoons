(function($){$.fn.reset=function(){return this.each(function(){if(typeof this.reset=="function"||(typeof this.reset=="object"&&!this.reset.nodeType)){this.reset()}})};$.fn.enable=function(){return this.each(function(){this.disabled=false})};$.fn.disable=function(){return this.each(function(){this.disabled=true})}})(jQuery);(function($){$.extend({fieldEvent:function(el,obs){var field=el[0]||el,e="change";if(field.type=="radio"||field.type=="checkbox"){e="click"}else{if(obs&&(field.type=="text"||field.type=="textarea"||field.type=="password")){e="keyup"}}return e}});$.fn.extend({delayedObserver:function(delay,callback){var el=$(this);if(typeof window.delayedObserverStack=="undefined"){window.delayedObserverStack=[]}if(typeof window.delayedObserverCallback=="undefined"){window.delayedObserverCallback=function(stackPos){var observed=window.delayedObserverStack[stackPos];if(observed.timer){clearTimeout(observed.timer)}observed.timer=setTimeout(function(){observed.timer=null;observed.callback(observed.obj,observed.obj.formVal())},observed.delay*1000);observed.oldVal=observed.obj.formVal()}}window.delayedObserverStack.push({obj:el,timer:null,delay:delay,oldVal:el.formVal(),callback:callback});var stackPos=window.delayedObserverStack.length-1;if(el[0].tagName=="FORM"){$(":input",el).each(function(){var field=$(this);field.bind($.fieldEvent(field,delay),function(){var observed=window.delayedObserverStack[stackPos];if(observed.obj.formVal()==observed.oldVal){return}else{window.delayedObserverCallback(stackPos)}})})}else{el.bind($.fieldEvent(el,delay),function(){var observed=window.delayedObserverStack[stackPos];if(observed.obj.formVal()==observed.oldVal){return}else{window.delayedObserverCallback(stackPos)}})}},formVal:function(){var el=this[0];if(el.tagName=="FORM"){return this.serialize()}if(el.type=="checkbox"||el.type=="radio"){return this.filter("input:checked").val()||""}else{return this.val()}}})})(jQuery);(function($){$.fn.extend({visualEffect:function(o,options){if(options){speed=options.duration*1000}else{speed=null}e=o.replace(/\_(.)/g,function(m,l){return l.toUpperCase()});return eval("$(this)."+e+"("+speed+")")},appear:function(speed,callback){return this.fadeIn(speed,callback)},blindDown:function(speed,callback){return this.show("blind",{direction:"vertical"},speed,callback)},blindUp:function(speed,callback){return this.hide("blind",{direction:"vertical"},speed,callback)},blindRight:function(speed,callback){return this.show("blind",{direction:"horizontal"},speed,callback)},blindLeft:function(speed,callback){this.hide("blind",{direction:"horizontal"},speed,callback);return this},dropOut:function(speed,callback){return this.hide("drop",{direction:"down"},speed,callback)},dropIn:function(speed,callback){return this.show("drop",{direction:"up"},speed,callback)},fade:function(speed,callback){return this.fadeOut(speed,callback)},fadeToggle:function(speed,callback){return this.animate({opacity:"toggle"},speed,callback)},fold:function(speed,callback){return this.hide("fold",{},speed,callback)},foldOut:function(speed,callback){return this.show("fold",{},speed,callback)},grow:function(speed,callback){return this.show("scale",{},speed,callback)},highlight:function(speed,callback){return this.show("highlight",{},speed,callback)},puff:function(speed,callback){return this.hide("puff",{},speed,callback)},pulsate:function(speed,callback){return this.show("pulsate",{},speed,callback)},shake:function(speed,callback){return this.show("shake",{},speed,callback)},shrink:function(speed,callback){return this.hide("scale",{},speed,callback)},squish:function(speed,callback){return this.hide("scale",{origin:["top","left"]},speed,callback)},slideUp:function(speed,callback){return this.hide("slide",{direction:"up"},speed,callback)},slideDown:function(speed,callback){return this.show("slide",{direction:"up"},speed,callback)},switchOff:function(speed,callback){return this.hide("clip",{},speed,callback)},switchOn:function(speed,callback){return this.show("clip",{},speed,callback)}})})(jQuery);

/*==================================================
  $Id: tabber.js,v 1.9 2006/04/27 20:51:51 pat Exp $
  tabber.js by Patrick Fitzgerald pat@barelyfitz.com

  Documentation can be found at the following URL:
  http://www.barelyfitz.com/projects/tabber/

  License (http://www.opensource.org/licenses/mit-license.php)

  Copyright (c) 2006 Patrick Fitzgerald

  Permission is hereby granted, free of charge, to any person
  obtaining a copy of this software and associated documentation files
  (the "Software"), to deal in the Software without restriction,
  including without limitation the rights to use, copy, modify, merge,
  publish, distribute, sublicense, and/or sell copies of the Software,
  and to permit persons to whom the Software is furnished to do so,
  subject to the following conditions:

  The above copyright notice and this permission notice shall be
  included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
  ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
  ==================================================*/

function tabberObj(argsObj)
{
  var arg; /* name of an argument to override */

  /* Element for the main tabber div. If you supply this in argsObj,
     then the init() method will be called.
  */
  this.div = null;

  /* Class of the main tabber div */
  this.classMain = "tabber";

  /* Rename classMain to classMainLive after tabifying
     (so a different style can be applied)
  */
  this.classMainLive = "tabberlive";

  /* Class of each DIV that contains a tab */
  this.classTab = "tabbertab";

  /* Class to indicate which tab should be active on startup */
  this.classTabDefault = "tabbertabdefault";

  /* Class for the navigation UL */
  this.classNav = "tabbernav";

  /* When a tab is to be hidden, instead of setting display='none', we
     set the class of the div to classTabHide. In your screen
     stylesheet you should set classTabHide to display:none.  In your
     print stylesheet you should set display:block to ensure that all
     the information is printed.
  */
  this.classTabHide = "tabbertabhide";

  /* Class to set the navigation LI when the tab is active, so you can
     use a different style on the active tab.
  */
  this.classNavActive = "tabberactive";

  /* Elements that might contain the title for the tab, only used if a
     title is not specified in the TITLE attribute of DIV classTab.
  */
  this.titleElements = ['h1'];

  /* Should we strip out the HTML from the innerHTML of the title elements?
     This should usually be true.
  */
  this.titleElementsStripHTML = true;

  /* If the user specified the tab names using a TITLE attribute on
     the DIV, then the browser will display a tooltip whenever the
     mouse is over the DIV. To prevent this tooltip, we can remove the
     TITLE attribute after getting the tab name.
  */
  this.removeTitle = true;

  /* If you want to add an id to each link set this to true */
  this.addLinkId = false;

  /* If addIds==true, then you can set a format for the ids.
     <tabberid> will be replaced with the id of the main tabber div.
     <tabnumberzero> will be replaced with the tab number
       (tab numbers starting at zero)
     <tabnumberone> will be replaced with the tab number
       (tab numbers starting at one)
     <tabtitle> will be replaced by the tab title
       (with all non-alphanumeric characters removed)
   */
  this.linkIdFormat = '<tabberid>nav<tabnumberone>';

  /* You can override the defaults listed above by passing in an object:
     var mytab = new tabber({property:value,property:value});
  */
  for (arg in argsObj) { this[arg] = argsObj[arg]; }

  /* Create regular expressions for the class names; Note: if you
     change the class names after a new object is created you must
     also change these regular expressions.
  */
  this.REclassMain = new RegExp('\\b' + this.classMain + '\\b', 'gi');
  this.REclassMainLive = new RegExp('\\b' + this.classMainLive + '\\b', 'gi');
  this.REclassTab = new RegExp('\\b' + this.classTab + '\\b', 'gi');
  this.REclassTabDefault = new RegExp('\\b' + this.classTabDefault + '\\b', 'gi');
  this.REclassTabHide = new RegExp('\\b' + this.classTabHide + '\\b', 'gi');

  /* Array of objects holding info about each tab */
  this.tabs = new Array();

  /* If the main tabber div was specified, call init() now */
  if (this.div) {

    this.init(this.div);

    /* We don't need the main div anymore, and to prevent a memory leak
       in IE, we must remove the circular reference between the div
       and the tabber object. */
    this.div = null;
  }
}


/*--------------------------------------------------
  Methods for tabberObj
  --------------------------------------------------*/


tabberObj.prototype.init = function(e)
{
  /* Set up the tabber interface.

     e = element (the main containing div)

     Example:
     init(document.getElementById('mytabberdiv'))
   */

  var
  childNodes, /* child nodes of the tabber div */
  i, i2, /* loop indices */
  t, /* object to store info about a single tab */
  defaultTab=0, /* which tab to select by default */
  DOM_ul, /* tabbernav list */
  DOM_li, /* tabbernav list item */
  DOM_a, /* tabbernav link */
  aId, /* A unique id for DOM_a */
  headingElement; /* searching for text to use in the tab */

  /* Verify that the browser supports DOM scripting */
  if (!document.getElementsByTagName) { return false; }

  /* If the main DIV has an ID then save it. */
  if (e.id) {
    this.id = e.id;
  }

  /* Clear the tabs array (but it should normally be empty) */
  this.tabs.length = 0;

  /* Loop through an array of all the child nodes within our tabber element. */
  childNodes = e.childNodes;
  for(i=0; i < childNodes.length; i++) {

    /* Find the nodes where class="tabbertab" */
    if(childNodes[i].className &&
       childNodes[i].className.match(this.REclassTab)) {
      
      /* Create a new object to save info about this tab */
      t = new Object();
      
      /* Save a pointer to the div for this tab */
      t.div = childNodes[i];
      
      /* Add the new object to the array of tabs */
      this.tabs[this.tabs.length] = t;

      /* If the class name contains classTabDefault,
	 then select this tab by default.
      */
      if (childNodes[i].className.match(this.REclassTabDefault)) {
	defaultTab = this.tabs.length-1;
      }
    }
  }

  /* Create a new UL list to hold the tab headings */
  DOM_ul = document.createElement("ul");
  DOM_ul.className = this.classNav;
  
  /* Loop through each tab we found */
  for (i=0; i < this.tabs.length; i++) {

    t = this.tabs[i];

    /* Get the label to use for this tab:
       From the title attribute on the DIV,
       Or from one of the this.titleElements[] elements,
       Or use an automatically generated number.
     */
    t.headingText = t.div.title;

    /* Remove the title attribute to prevent a tooltip from appearing */
    if (this.removeTitle) { t.div.title = ''; }

    if (!t.headingText) {

      /* Title was not defined in the title of the DIV,
	 So try to get the title from an element within the DIV.
	 Go through the list of elements in this.titleElements
	 (typically heading elements ['h2','h3','h4'])
      */
      for (i2=0; i2<this.titleElements.length; i2++) {
	headingElement = t.div.getElementsByTagName(this.titleElements[i2])[0];
	if (headingElement) {
	  t.headingText = headingElement.innerHTML;
	  if (this.titleElementsStripHTML) {
	    t.headingText.replace(/<br>/gi," ");
	    t.headingText = t.headingText.replace(/<[^>]+>/g,"");
	  }
	  break;
	}
      }
    }

    if (!t.headingText) {
      /* Title was not found (or is blank) so automatically generate a
         number for the tab.
      */
      t.headingText = i + 1;
    }

    /* Create a list element for the tab */
    DOM_li = document.createElement("li");

    /* Save a reference to this list item so we can later change it to
       the "active" class */
    t.li = DOM_li;

    /* Create a link to activate the tab */
    DOM_a = document.createElement("a");
    DOM_a.appendChild(document.createTextNode(t.headingText));
    DOM_a.href = "javascript:void(null);";
    DOM_a.title = t.headingText;
    DOM_a.onclick = this.navClick;

    /* Add some properties to the link so we can identify which tab
       was clicked. Later the navClick method will need this.
    */
    DOM_a.tabber = this;
    DOM_a.tabberIndex = i;

    /* Do we need to add an id to DOM_a? */
    if (this.addLinkId && this.linkIdFormat) {

      /* Determine the id name */
      aId = this.linkIdFormat;
      aId = aId.replace(/<tabberid>/gi, this.id);
      aId = aId.replace(/<tabnumberzero>/gi, i);
      aId = aId.replace(/<tabnumberone>/gi, i+1);
      aId = aId.replace(/<tabtitle>/gi, t.headingText.replace(/[^a-zA-Z0-9\-]/gi, ''));

      DOM_a.id = aId;
    }

    /* Add the link to the list element */
    DOM_li.appendChild(DOM_a);

    /* Add the list element to the list */
    DOM_ul.appendChild(DOM_li);
  }

  /* Add the UL list to the beginning of the tabber div */
  e.insertBefore(DOM_ul, e.firstChild);

  /* Make the tabber div "live" so different CSS can be applied */
  e.className = e.className.replace(this.REclassMain, this.classMainLive);

  /* Activate the default tab, and do not call the onclick handler */
  this.tabShow(defaultTab);

  /* If the user specified an onLoad function, call it now. */
  if (typeof this.onLoad == 'function') {
    this.onLoad({tabber:this});
  }

  return this;
};


tabberObj.prototype.navClick = function(event)
{
  /* This method should only be called by the onClick event of an <A>
     element, in which case we will determine which tab was clicked by
     examining a property that we previously attached to the <A>
     element.

     Since this was triggered from an onClick event, the variable
     "this" refers to the <A> element that triggered the onClick
     event (and not to the tabberObj).

     When tabberObj was initialized, we added some extra properties
     to the <A> element, for the purpose of retrieving them now. Get
     the tabberObj object, plus the tab number that was clicked.
  */

  var
  rVal, /* Return value from the user onclick function */
  a, /* element that triggered the onclick event */
  self, /* the tabber object */
  tabberIndex, /* index of the tab that triggered the event */
  onClickArgs; /* args to send the onclick function */

  a = this;
  if (!a.tabber) { return false; }

  self = a.tabber;
  tabberIndex = a.tabberIndex;

  /* Remove focus from the link because it looks ugly.
     I don't know if this is a good idea...
  */
  a.blur();

  /* If the user specified an onClick function, call it now.
     If the function returns false then do not continue.
  */
  if (typeof self.onClick == 'function') {

    onClickArgs = {'tabber':self, 'index':tabberIndex, 'event':event};

    /* IE uses a different way to access the event object */
    if (!event) { onClickArgs.event = window.event; }

    rVal = self.onClick(onClickArgs);
    if (rVal === false) { return false; }
  }

  self.tabShow(tabberIndex);

  return false;
};


tabberObj.prototype.tabHideAll = function()
{
  var i; /* counter */

  /* Hide all tabs and make all navigation links inactive */
  for (i = 0; i < this.tabs.length; i++) {
    this.tabHide(i);
  }
};


tabberObj.prototype.tabHide = function(tabberIndex)
{
  var div;

  if (!this.tabs[tabberIndex]) { return false; }

  /* Hide a single tab and make its navigation link inactive */
  div = this.tabs[tabberIndex].div;

  /* Hide the tab contents by adding classTabHide to the div */
  if (!div.className.match(this.REclassTabHide)) {
    div.className += ' ' + this.classTabHide;
  }
  this.navClearActive(tabberIndex);

  return this;
};


tabberObj.prototype.tabShow = function(tabberIndex)
{
  /* Show the tabberIndex tab and hide all the other tabs */

  var div;

  if (!this.tabs[tabberIndex]) { return false; }

  /* Hide all the tabs first */
  this.tabHideAll();

  /* Get the div that holds this tab */
  div = this.tabs[tabberIndex].div;

  /* Remove classTabHide from the div */
  div.className = div.className.replace(this.REclassTabHide, '');

  /* Mark this tab navigation link as "active" */
  this.navSetActive(tabberIndex);

  /* If the user specified an onTabDisplay function, call it now. */
  if (typeof this.onTabDisplay == 'function') {
    this.onTabDisplay({'tabber':this, 'index':tabberIndex});
  }

  return this;
};

tabberObj.prototype.navSetActive = function(tabberIndex)
{
  /* Note: this method does *not* enforce the rule
     that only one nav item can be active at a time.
  */

  /* Set classNavActive for the navigation list item */
  this.tabs[tabberIndex].li.className = this.classNavActive;

  return this;
};


tabberObj.prototype.navClearActive = function(tabberIndex)
{
  /* Note: this method does *not* enforce the rule
     that one nav should always be active.
  */

  /* Remove classNavActive from the navigation list item */
  this.tabs[tabberIndex].li.className = '';

  return this;
};


/*==================================================*/


function tabberAutomatic(tabberArgs)
{
  /* This function finds all DIV elements in the document where
     class=tabber.classMain, then converts them to use the tabber
     interface.

     tabberArgs = an object to send to "new tabber()"
  */
  var
    tempObj, /* Temporary tabber object */
    divs, /* Array of all divs on the page */
    i; /* Loop index */

  if (!tabberArgs) { tabberArgs = {}; }

  /* Create a tabber object so we can get the value of classMain */
  tempObj = new tabberObj(tabberArgs);

  /* Find all DIV elements in the document that have class=tabber */

  /* First get an array of all DIV elements and loop through them */
  divs = document.getElementsByTagName("div");
  for (i=0; i < divs.length; i++) {
    
    /* Is this DIV the correct class? */
    if (divs[i].className &&
	divs[i].className.match(tempObj.REclassMain)) {
      
      /* Now tabify the DIV */
      tabberArgs.div = divs[i];
      divs[i].tabber = new tabberObj(tabberArgs);
    }
  }
  
  return this;
}


/*==================================================*/


function tabberAutomaticOnLoad(tabberArgs)
{
  /* This function adds tabberAutomatic to the window.onload event,
     so it will run after the document has finished loading.
  */
  var oldOnLoad;

  if (!tabberArgs) { tabberArgs = {}; }

  /* Taken from: http://simon.incutio.com/archive/2004/05/26/addLoadEvent */

  oldOnLoad = window.onload;
  if (typeof window.onload != 'function') {
    window.onload = function() {
      tabberAutomatic(tabberArgs);
    };
  } else {
    window.onload = function() {
      oldOnLoad();
      tabberAutomatic(tabberArgs);
    };
  }
}


/*==================================================*/


/* Run tabberAutomaticOnload() unless the "manualStartup" option was specified */

if (typeof tabberOptions == 'undefined') {

    tabberAutomaticOnLoad();

} else {

  if (!tabberOptions['manualStartup']) {
    tabberAutomaticOnLoad(tabberOptions);
  }

}


(function($){
  $(function(){
		$.inPlaceEditor = {
      toggle: function() {
        $([this.attribute, this.form]).toggle()

        if (this.form.is(':visible'))
          $.inPlaceEditor.form.find('fieldset li:nth-child(1)')
      }
    }

    $('.in_place_attribute').live('click', function() {
      $.inPlaceEditor.attribute = $(this)
      $.inPlaceEditor.form = $.inPlaceEditor.attribute.next()
      $.inPlaceEditor.toggle() 
    })

    $('.in_place_save').live('click', function() {
      $.inPlaceEditor.form = $(this).parent('form')
      $.inPlaceEditor.attribute = $.inPlaceEditor.form.prev()
      $.ajax({
        url: $.inPlaceEditor.form[0].action,
        type: "POST",
        dataType: "script",
        data: $.inPlaceEditor.form.serializeArray()
      })
      return false
    })

    $('.in_place_cancel').live('click', function() {
      $.inPlaceEditor.form = $(this).parent('form')
      $.inPlaceEditor.attribute = $.inPlaceEditor.form.prev()
      $.inPlaceEditor.toggle()
    })
  })
})(jQuery)


// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var no_gallery = true;
var current_image_filename = "";
var showing_modal = false;
var first = true;

$(document).ready(function(){
    
    
   $('marquee').marquee('pointer').mouseover(function () {
 $(this).trigger('stop');
 }).mouseout(function () {
 $(this).trigger('start');
 }).mousemove(function (event) {
 if ($(this).data('drag') == true) {
 this.scrollLeft = $(this).data('scrollX') + ($(this).data('x') - event.clientX);
 }
 }).mousedown(function (event) {
 $(this).data('drag', true).data('x', event.clientX).data('scrollX', this.scrollLeft);
 }).mouseup(function () {
 $(this).data('drag', false);
 });
  
      
  $("a.close_comments").live('click',function(){
    
    post_id = $(this).attr('rel');
    $("#lista_comentarios_" + post_id).hide(1000);
    return false;
    // "lista_comentarios_#{post.id}" post.id  
  })   
    
  $('.post_list_item .post_item .post_content').truncate({max_length: 300});   
   
   
  $('a[name=modal]').click(function(e) {  
      
      load_box(e);
    
  });  
    
  //if close button is clicked  
  $('.window .close').live('click',function (e) {  
      //Cancel the link behavior  
      close_modal();
      return false;
  });       
    
  //if mask is clicked  
  $('#mask').live('click',function () {  
      $(this).hide();  
      showing_modal = false;
      $('.window').hide();  
  });
  
     
   
    // form p { position:relative }
    // label  { position:absolute; top:0; left:0}
    $("li#post_title_input").css({'position':'relative'});
    $("li#post_title_input label").css({'position':'absolute','top':'0','left':'0'});
    $("li#post_title_input label").inFieldLabels();
    $("li#comment_name_input").css({'position':'relative'});
    $("li#comment_name_input label").css({'position':'absolute','top':'0','left':'0'});
    $("li#comment_name_input label").inFieldLabels();

    $("li#comment_email_input").css({'position':'relative'});
    $("li#comment_email_input label").css({'position':'absolute','top':'0','left':'0'});
    $("li#comment_email_input label").inFieldLabels();

    $("li#comment_website_input").css({'position':'relative'});
    $("li#comment_website_input label").css({'position':'absolute','top':'0','left':'0'});
    $("li#comment_website_input label").inFieldLabels();

    $("div#search_box form p").css({'position':'relative'});
    $("div#search_box form p label").css({'position':'absolute','top':'0','left':'0'});
    $("div#search_box form p label").inFieldLabels();
    
    $("input#blog_search_field").search();
    
    $(".edit_post_link").hide();
    $("tr.post_row").hover(function(){
      $(".edit_post_link").hide();
      $(this).find(".edit_post_link").show();
      
    },function(){
      
      $(".edit_post_link").hide();
      
      
    });
    
    $(".hint").each(function(){
      
      $(this).simpletip({
          content: $(this).attr("rel"), 
          fixed: true,
          position: "top",
          offset: [80,-20]
          });
      
    });
    
    $("div#categories.side_fields").css({'margin-bottom': '10px'});
    
    
    $(".side_content").hide();
    $(".new_cat").toggle(
      function(){ 
        $(this).removeClass("hint");
        $(this).text("Cancelar")
        $("div#categories.side_fields").css({'margin-bottom': '0px'});
        $(".side_content").slideDown(function(){
          
          $("#category_name").focus();
          
          
        }); 

        },
      
      function(){
        $(this).text("Nueva categoría")
        $(".side_content").slideUp(function(){$("div#categories.side_fields").css({'margin-bottom': '10px'})});
        $(this).addClass("hint");
        }
      
      );
      
      $("div#fancy_div input#submit_url").live('click',function(){
        $(this).val("Enviando...");
      });  
      
      
      $("#send_category").click(function(){
        
        name = $("#category_name").attr('value');
        user_id = $("#category_user_id").attr('value');
        $("#send_category").val("Enviando...");
        $.ajax({
                type:"POST",
                url:"/categorias",
                data:({'category[user_id]':user_id,'category[name]':name}),
                dataType:"script",
                success: function(msg){
                  $("#send_category").val("Grabar");
                  $(".new_cat").click; //(function(){$("div#categories.side_fields").css({"margin-bottom": "10px"})});
//                  $(this).addClass("hint");
                  
                  }
                });
        return false;
      });    
    
    $(".image_actions").hide();
    
    //$('input:password').dPassword();     
    $("a.open-inline").fancybox({
      'hideOnContentClick':false,      
      'padding':20,
      'frameHeight':300,
      'overlayOpacity':0.7
    });

    $("a.open-inline.large").fancybox({
      
      'padding':20,
      'frameWidth':840,
      'frameHeight':320,
      'hideOnContentClick':false,
      'centerOnScroll':false,
      'callbackOnShow':start_upload,
      'overlayOpacity':0.7
      //Loads photo gallery
    });

    
    // Cleans empty parragraphs and divs
    $("p:empty").hide();

    $('.ajax_pagination div.pagination a').live('click', function() {
      $.getScript(this.href);
      return false
    });
        

});

function start_upload(e){

  load_box(e);  
  if (first){
  setup_carousel();
  setup_swfupload();    
  first = false;
  }
}
  
function setup_carousel(){
  
  $('#uploaded_images_carousel').jcarousel({
      'scroll':3,
      'visible':5
  });
  
}

$(window).resize(function() {


  if (showing_modal==true){
  var id = "#dialog";
  //Get the screen height and width  
  var maskHeight = $(document).height();  
  var maskWidth = $(window).width();  

    //Set height and width to mask to fill up the whole screen  
    $('#mask').css({'width':maskWidth,'height':maskHeight});  
  
    //transition effect       
     $('#mask').fadeIn(0);      
     $('#mask').fadeTo(0,0.3);    

    //Get the window height and width  
    var winH = $(window).height();  
    var winW = $(window).width();  
            
    //Set the popup window to center  
    $(id).css('top', 180);  
    $(id).css('left', winW/2-$(id).width()/2);  
  }
});

function close_modal(){
  
  showing_modal = false;
  $('#mask, .window').hide();  
  
  
}


function load_box(e){
//Cancel the link behavior  

    showing_modal = true;
    e.preventDefault();  
    //Get the A tag  
    // var id = $(this).attr('href');  
    var id = "#dialog";
    //Get the screen height and width  
    var maskHeight = $(document).height();  
    var maskWidth = $(window).width();  

    //Set height and width to mask to fill up the whole screen  
    $('#mask').css({'width':maskWidth,'height':maskHeight});  
  
    //transition effect       
     $('#mask').fadeIn(0);      
     $('#mask').fadeTo(0,0.3);    

    //Get the window height and width  
    var winH = $(window).height();  
    var winW = $(window).width();  
        
    //Set the popup window to center  
    $(id).css('top',  180);  
    $(id).css('left', winW/2-$(id).width()/2);  

    //transition effect  
    $(id).fadeIn(0);

};

function setup_swfupload(){
  
	$('#swfupload-control').swfupload({
		upload_url: token, 
		file_post_name: 'blog_image[image]',
		file_size_limit : "1024",
		file_types : "*.jpg;*.png;*.gif",
		file_types_description : "Image files",
		file_upload_limit : 15,
		flash_url : "/swfupload.swf",
		relative_urls: true,
		document_base_url : "http://blogs.semanaeconomica.com/",
		button_image_url : '/upload_buttons.png',
		button_width: 110,
		button_height: 22,
		button_placeholder : $('input#upload_button')[0],
		button_placeholder_id : "input#upload_button",
		debug: true
	}).bind('fileQueued', function(event, file){
  			var listitem='<li id="'+file.id+'" >'+
  				'Archivo: <em>'+file.name+'</em> ('+Math.round(file.size/1024)+' KB) <span class="progressvalue" ></span>'+
  				'<div class="progressbar" ><div class="progress" ></div></div>'+
  				'<p class="status" >Pendiente</p>'+
  				'<span class="cancel" >&nbsp;</span>'+
  				'</li>';
  			$('#fancy_div #log').prepend(listitem);
  			$('li#'+file.id+' .cancel').bind('click', function(){ //Remove from queue on cancel click
  				var swfu = $.swfupload.getInstance('#swfupload-control');
  				swfu.cancelUpload(file.id);
  				$('li#'+file.id).slideUp('fast');
  			});
  			// start the upload since it's queued
  			$(this).swfupload('startUpload');
  		})
  		.bind('fileQueueError', function(event, file, errorCode, message){
  			alert('El archivo es mayor al limite permitido');
  		})
  		.bind('fileDialogComplete', function(event, numFilesSelected, numFilesQueued){
  			$('#fancy_div #queuestatus').text('Files Selected: '+numFilesSelected+' / Queued Files: '+numFilesQueued);
  		})
  		.bind('uploadStart', function(event, file){
  			$('#fancy_div #log li#'+file.id).find('p.status').text('Enviando...');
  			$('#fancy_div #log li#'+file.id).find('span.progressvalue').text('0%');
  			$('#fancy_div #log li#'+file.id).find('span.cancel').hide();
  		})
  		.bind('uploadProgress', function(event, file, bytesLoaded){
  			//Show Progress
  			var percentage=Math.round((bytesLoaded/file.size)*100);
  			$('#fancy_div #log li#'+file.id).find('div.progress').css('width', percentage+'%');
  			$('#fancy_div #log li#'+file.id).find('span.progressvalue').text(percentage+'%');
  		})
  		.bind('uploadSuccess', function(event, file, serverData){
  			var item=$('#fancy_div #log li#'+file.id);
  			item.find('div.progress').css('width', '100%');
  			item.find('span.progressvalue').text('100%');
  			var pathtofile='<a href="/'+file.name+'" target="_blank" >ver</a>';
  			item.addClass('success').find('p.status').html('Imagen enviada correctamente');
     
        // console.debug(serverData);
        
        response = serverData.split("::");
        id = response[0];
        filename = response[1];
        alt = filename.split("/").pop();
        alt = alt.split("?")[0].split(".")[0];
        
        $("ul#uploaded_images_carousel").prepend("<li><img alt=\"" + alt + "\" height=\"75\" src=\"" + filename +"\" width=\"75\" /><span id=\"" + id  +"\"></span>\n</li>\n"); 
        $("#fancy_outer #blog_displayed_images").effect('highlight'); 
        $('#fancy_div input#submit_url').val('Agregar');    
        $("input#blog_image_image_url").val("") 
        setup_carousel(); 
        $("div#fancy_div div#error").replaceWith("<div id='error'></div>"); 
        
        selectImage(filename,id);
  			// eval(serverData);
  		})
  		.bind('uploadComplete', function(event, file){
  			// upload has completed, try the next one in the queue
  			$(this).swfupload('startUpload');
  		});
  		
  		$(".jcarousel-item img").live("click",function(){
  		  		  
  		  image_file_path = $(this).attr("src");
  		  current_image_filename = image_file_path;
        image_id = $(this).parent().find("span")[0].id
        selectImage(current_image_filename,image_id);
  		});
  		
  		$(".close_fancybox").click(function(){  		  
  		  $.fn.fancybox.close();
  		  return false;
  		});
  		
  		
  		
  		$(".insert_image").click(function(event){

        event.stopPropagation();
        //Obtenemos lo actual
        // current_html = tinyMCE.activeEditor.getContent();
  		  
        //Obtenemos el tamaño elegido 
        image_size = $("input[@name='size']:checked").val();
        
        image_id = $("#fancy_div #selected_image .image_filename p").attr("rel");
        
        if (!image_id) {
            
            alert("Debe elegir una imagen a insertar");
            return true;
          
        }
        
        switch (image_size) {
        case "small": 
          displaySmallImage(current_image_filename)
          break; 
        default: 
          //Creación de imagen normal
          getImageURLPerSize(image_id,image_size)
        }
  		  
  		  return false;

  		})
  		
  };
  
  var image_filename = "";
  var image = "";
  
  function displaySmallImage(current_image_filename){
    
    //Creación de imagen normal
    base_url = "http://secom_blogs.local";
    base_url = "http://blogs.semanaeconomica.com";
    
    image_filename = base_url + current_image_filename.substr();
    //image_filename = current_image_filename;
    new_image = "<img src='"+ image_filename +"'/>";
    new_image = link_around(new_image,image_filename);
    // current_html += new_image;
    // tinyMCE.activeEditor.setContent(current_html);
	  tinyMCE.execCommand("mceInsertContent",false,new_image);
	  $("input#url").val("");
    // $.fn.fancybox.close();
    close_modal();
    
    
  }
  
  function link_to_original() {

     //Obtenemos el tamaño elegido 
      action = $("input[@name='image_action']:checked").val();
      return action == "to_original";
    
  }
  
  
  function selectImage(filename,image_id){
	  
	  var str = filename.split("/").pop().split("?")[0];  		  
	  var image_str = "<img src='" + filename  + "' alt='Imagen " + str + "' title='" + str +"' width='75' height='75'/>"
	   
	  
	  $("#fancy_div #selected_image .image_thumbnail").html(image_str);
	  $("#fancy_div #selected_image .image_filename p").html(str);
	  $("#fancy_div #selected_image .image_filename p").attr("rel",image_id); 
    $("#fancy_div #selected_image").effect("highlight");

	  $(".image_actions").show();

	  
	}
	
	
  function link_around(new_image,current_image_filename){

      //Obtenemos el enlace, si éste existe
  	  link_dest = jQuery("input#url").val();
    
     // ¿ Es un enlace ? 
  	  if (link_dest != ""){
  	    new_image = "<a href='"+ link_dest +"'>" + new_image + "</a>";
  	  }
  	  
  	  if (link_to_original){
  	    path = current_image_filename.split("/");
        path[6] = "original";
        original_link = path.join("/");
  	    new_image = "<a href='"+ original_link +"' class='open-inline' >" + new_image + "</a>";  	    
  	    
  	  }
  	  
  	  return new_image;
    
  }
  
  function getImageURLPerSize(id,size){
    
    $.get("/fotos_blog/"+id+"/get_size_url",{size:size},function(returned_data){
      
      // alert(returned_data);
        image_filename = returned_data;
        displaySmallImage(image_filename); 
        // image_filename = image_filename;
      
    },'text');    

    return true;
  }

  function triggerFancyBox(e){
  
    // $("a.open-inline.large").fancybox({
    //   
    //   'padding':20,
    //   'frameWidth':940,
    //   'frameHeight':520,
    //   'hideOnContentClick':false,
    //   'centerOnScroll':false,
    //   'callbackOnShow':start_upload  
    //   //Loads photo gallery
    // }).trigger("click");
    // 
    // 
    start_upload(e);
    $('#fancybox_images').show();
    
  }

  $.fn.search = function() {
  	return this.focus(function() {
  		if( this.value == this.defaultValue ) {
  			this.value = "";
  		}
  	}).blur(function() {
  		if( !this.value.length ) {
  			this.value = this.defaultValue;
  		}
  	});
  };
  
  
  $(document).keyup(function(e) {  
    if(e.keyCode == 27) {  
      $('#mask').hide();  
      $('.window').hide();  
    }  
  });

	    // 
	   //  
	   // .bind('fileQueued', function(event, file){
	   //  var listitem='<li id="'+file.id+'" >'+
	   //    'Imagen: <em>'+file.name+'</em> ('+Math.round(file.size/1024)+' KB) <span class="progressvalue" ></span>'+
	   //    '<div class="progressbar" ><div class="progress" ></div></div>'+
	   //    '<p class="status" >Esperando</p>'+
	   //    '<span class="cancel" >&nbsp;</span>'+
	   //    '</li>';
	   //  $('#log').append(listitem);
	   //  $('li#'+file.id+' .cancel').bind('click', function(){ //Remove from queue on cancel click
	   //    var swfu = $.swfupload.getInstance('#swfupload-control');
	   //    swfu.cancelUpload(file.id);
	   //    $('li#'+file.id).slideUp('fast');
	   //  });
	   //  // start the upload since it's queued
	   //  $(this).swfupload('startUpload');
	   // })
	   // .bind('fileQueueError', function(event, file, errorCode, message){
	   //  alert('El tamaño de '+file.name+' es mayor al límite');
	   // })
	   // .bind('fileDialogComplete', function(event, numFilesSelected, numFilesQueued){
	   //  $('#queuestatus').text('Archivos seleccionados: '+numFilesSelected+' Queued Files: '+numFilesQueued);
	   // })
	   // .bind('uploadStart', function(event, file){
	   //  $('#log li#'+file.id).find('p.status').text('Enviando...');
	   //  $('#log li#'+file.id).find('span.progressvalue').text('0%');
	   //  $('#log li#'+file.id).find('span.cancel').hide();
	   // })
	   // .bind('uploadProgress', function(event, file, bytesLoaded){
	   //  //Show Progress
	   //  var percentage=Math.round((bytesLoaded/file.size)*100);
	   //  $('#log li#'+file.id).find('div.progress').css('width', percentage+'%');
	   //  $('#log li#'+file.id).find('span.progressvalue').text(percentage+'%');
	   // })
	   // .bind('uploadSuccess', function(event, file, serverData){
	   //  var item=$('#log li#'+file.id);
	   //  item.find('div.progress').css('width', '100%');
	   //  item.find('span.progressvalue').text('100%');
	   //       // var pathtofile='<a href="uploads/'+file.name+'" target="_blank" >view &raquo;</a>';
	   //  item.addClass('success').find('p.status').html('¡Finalizado!');
	   //  eval(serverData);
	   // })
	   // .bind('uploadComplete', function(event, file){
	   //  // upload has completed, try the next one in the queue
	   //  $(this).swfupload('startUpload');
	   // })
//}

