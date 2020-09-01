var action = function() { }

Action.prototype = {
    
    run: function(parameters) {
        parameters.completionFunction({"URL": document.URL, "title": document.title
        });
    },
    
    
    finalise: function(parameters) {
        
    },
};

var ExtensionPreprocessingJS = new Action
