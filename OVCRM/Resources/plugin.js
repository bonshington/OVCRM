String.prototype.format = function (args) {
    var newStr = this;
    for (var key in args) {
        newStr = newStr.replace('{' + key + '}', args[key]);
    }
    return newStr;
}

var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

(function($){
 
 $.fn.display =  function(dataType){
   switch(dataType){
     case "datetime":
        
        var self = this;
        var val = self.attr("datetime");
 
        if(val.length > 0){
            try{    
                var date = val.split("T")[0].split("-");
                var time = val.split("T")[1].split(":");
 
                var result = new Date(date[0], date[1], date[2], time[0], time[1]);
                result.setMinutes(result.getMinutes() + (-(new Date()).getTimezoneOffset()));
 
                self.text(result.getDate()+" "+months[result.getMonth() - 1]+" "+result.getFullYear()+" - "+result.getHours()+":"+result.getMinutes());
            } catch(err){}
        }
        break;
    }
 };
 
})(jQuery);
