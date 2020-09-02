var action = function() { }

Action.prototype = {
    
    run: function(parameters) {
        parameters.completionFunction({"URL": document.URL, "title": document.title
        });
    },
    
    
    finalize: function(parameters) {
        var customJavaScript = parameters["customJavaScript"];
        eval(customJavaScript); //run this code immediately
    }
};

var ExtensionPreprocessingJS = new Action
