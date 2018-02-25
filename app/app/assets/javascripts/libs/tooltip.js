
tooltip_title = "";
tooltip_description = "";
tooltip_position = 0;
tooltip_steps = []
tooltip_eval_on_close = ""
function openTooltip(){
    tooltip_position= -1;
    nextTooltip();
    document.querySelector('#tooltip_balloon').style.display = 'initial';
}

function closeTooltip(){
    document.querySelector('#tooltip_balloon').style.display = 'none';
}
function setTooltip(array){
    tooltip_steps = Array();
    tooltip_eval_on_close = "";
    for(var a=0; a < array.length; a++){
      tooltip_steps[a] = Object();
      tooltip_steps[a]['title'] = array[a]['title'];
      tooltip_steps[a]['description'] = array[a]['description'];
      tooltip_steps[a]['element'] = array[a]['element'];
      tooltip_steps[a]['position'] = array[a]['position'];
      if(array[a]['left'] != undefined){
        tooltip_steps[a]['left'] = array[a]['left'];
      }else{
        tooltip_steps[a]['left'] = 0;
      }
      if(array[a]['top'] != undefined){
        tooltip_steps[a]['top'] = array[a]['top'];
      }else{
        tooltip_steps[a]['top'] = 0;
      }
      if(array[a]['pin_top'] != undefined){
        tooltip_steps[a]['pin_top'] = array[a]['pin_top'];
      }else{
        tooltip_steps[a]['pin_top'] = 0;
      }
      if(array[a]['pin_left'] != undefined){
        tooltip_steps[a]['pin_left'] = array[a]['pin_left'];
      }else{
        tooltip_steps[a]['pin_left'] = 0;
      }
      if(array[a]['before'] != undefined){
        tooltip_steps[a]['before'] = array[a]['before'];
      }else{
        tooltip_steps[a]['before'] = "";
      }

    }
}
function nextTooltip(){
    if(tooltip_position+1 == tooltip_steps.length){
        closeTooltip();
        if(tooltip_eval_on_close != ""){
            eval(tooltip_eval_on_close);
        }
    }else{
      tooltip_position+=1;

      if(tooltip_steps[tooltip_position]['before'] != ""){
        eval(tooltip_steps[tooltip_position]['before'])
      }
      $('#tooltip_title').html(tooltip_steps[tooltip_position]['title']);
      $('#tooltip_description').html(tooltip_steps[tooltip_position]['description']);
      switch(tooltip_steps[tooltip_position]['position']){
        case 'left':
          element = $(tooltip_steps[tooltip_position]['element']);
          document.querySelector('#tooltip_balloon').style.marginLeft = ($(element).width()+$(element).offset().left+tooltip_steps[tooltip_position]['left'])+"px";
          document.querySelector('#tooltip_balloon').style.marginTop = ($(element).height()+$(element).offset().top+tooltip_steps[tooltip_position]['top'])+"px";
          document.querySelector('#tooltip_pin').style.marginLeft = ($(element).width()+$(element).offset().left-10+tooltip_steps[tooltip_position]['left'])+"px";
          document.querySelector('#tooltip_pin').style.marginTop = ($(element).height()+$(element).offset().top-6+tooltip_steps[tooltip_position]['top']+tooltip_steps[tooltip_position]['pin_top'])+"px";
          break;
        case 'top':
          element = $(tooltip_steps[tooltip_position]['element']);
          document.querySelector('#tooltip_balloon').style.marginLeft = ($(element).offset().left+tooltip_steps[tooltip_position]['left'])+"px";
          document.querySelector('#tooltip_balloon').style.marginTop = ($(element).height()+$(element).offset().top+tooltip_steps[tooltip_position]['top'])+"px";
          document.querySelector('#tooltip_pin').style.marginLeft = ($(element).offset().left+7+tooltip_steps[tooltip_position]['left']+tooltip_steps[tooltip_position]['pin_left'])+"px";
          document.querySelector('#tooltip_pin').style.marginTop = ($(element).height()+$(element).offset().top-30+tooltip_steps[tooltip_position]['top'])+"px";
          break;
        case 'button':
          element = $(tooltip_steps[tooltip_position]['element']);
          document.querySelector('#tooltip_balloon').style.marginLeft = ($(element).offset().left+tooltip_steps[tooltip_position]['left'])+"px";
          document.querySelector('#tooltip_balloon').style.marginTop = ($(element).offset().top-document.querySelector('#tooltip_balloon').style.width+tooltip_steps[tooltip_position]['top'])+"px";
          document.querySelector('#tooltip_pin').style.marginLeft = ($(element).offset().left+12+tooltip_steps[tooltip_position]['left'])+"px";
          document.querySelector('#tooltip_pin').style.marginTop = ($(element).offset().top+$(document.querySelector('#tooltip_balloon')).height()-30+tooltip_steps[tooltip_position]['top'])+"px";
          break;
        case 'right':
          element = $(tooltip_steps[tooltip_position]['element']);
          document.querySelector('#tooltip_balloon').style.marginLeft = ($(element).offset().left-$(document.querySelector('#tooltip_balloon')).width()+tooltip_steps[tooltip_position]['left'])+"px";
          document.querySelector('#tooltip_balloon').style.marginTop = ($(element).offset().top+tooltip_steps[tooltip_position]['top'])+"px";
          document.querySelector('#tooltip_pin').style.marginLeft = ($(element).offset().left-document.querySelector('#tooltip_balloon').style.width-10+tooltip_steps[tooltip_position]['left']+tooltip_steps[tooltip_position]['pin_left'])+"px";
          document.querySelector('#tooltip_pin').style.marginTop = ($(element).offset().top+tooltip_steps[tooltip_position]['top']+tooltip_steps[tooltip_position]['pin_top'])+"px";
          break;
      }
    }
}
function setExecutationOnCloseTooltip(val){
    tooltip_eval_on_close = val;
}