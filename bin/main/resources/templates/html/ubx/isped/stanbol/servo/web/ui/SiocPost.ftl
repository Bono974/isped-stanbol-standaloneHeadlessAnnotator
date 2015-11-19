<@namespace ont="http://example.org/service-description#" />
<@namespace ehub="http://stanbol.apache.org/ontology/entityhub/entityhub#" />
<@namespace cc="http://creativecommons.org/ns#" />
<@namespace dct="http://purl.org/dc/terms/" />
<@namespace sioc="http://rdfs.org/sioc/ns#" />
<!DOCTYPE html>
<html xmlns:sioc="http://rdfs.org/sioc/ns#">
  <head>
    <title>ServO endpoint</title>

<!--
    <link rel="stylesheet" href="custom.css" />
    
    <script src="./js/deps/jquery-1.7.1.min.js"></script>
    <script src="./js/deps/jquery-ui-1.8.18.custom.min.js"></script>
    <script src="./js/deps/modernizr.custom.80485.js"></script>
    <script src="./js/deps/underscore-min.js"></script>
    <script src="./js/deps/backbone-min.js"></script>
    <script src="./js/deps/vie-min.js"></script>
    <script src="./js/deps/jquery.rdfquery.min.js"></script>
    <script src="./js/deps/annotate-min.js"></script>
       
     <script src="./js/create.js"></script>
    
     <script src="./demo/create-editor.js"></script> 
    
    <link rel="stylesheet" href="./js/deps/font-awesome/css/font-awesome.css" />
    <link rel="stylesheet" href="./css/themes/create-ui/css/create-ui.css" />
    <link rel="stylesheet" href="./css/themes/midgard-notifications/midgardnotif.css" />
    <link rel="stylesheet" href="http://cdn.aloha-editor.org/latest/css/aloha.css" />
    
    <link href="http://fonts.googleapis.com/css?family=Cantarell" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="./css/bootstrap.css" />
    <link rel="stylesheet" href="./css/create-2012.css" />
    <link rel="shortcut icon" href="./img/favicon.png" />
    
    <link rel="canonical" href="http://localhost:8080/" />

    <script> 
     var Aloha = window.Aloha || ( window.Aloha = {} );
     Aloha.settings = { 
     	locale: 'en', sidebar: { 
     		disabled: true 
     	}, 
    	placeholder: { '*': 'Add content here' },
        plugins: { 
        	format: { 
				config: [  'b', 'i', 'p', 'sub', 'sup', 'del', 'title', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'pre', 'removeFormat' ] 
			} 
		} 
	}			
  	</script> <!-- Include Aloha Editor and load desired plugins --> 
 <!-- 	<script src='http://cdn.aloha-editor.org/latest/lib/aloha.js'  data-aloha-plugins='common/format, common/table, common/list, common/link, common/block, common/undo, common/contenthandler, common/paste, common/commands, common/abbr'></script>
  
  
  -->
  
  
      <link rel="stylesheet" href="font-awesome/css/font-awesome.css" />
    
    <link rel="stylesheet" href="themes/create-ui/css/create-ui.css" />
    
    <link rel="stylesheet" href="themes/midgard-notifications/midgardnotif.css" />
    
    <link rel="stylesheet" href="custom.css" />
    
    <script src="almond-0.0.2-alpha-1.js" > </script>
    <script src="jquery-amd-1.7.1-alpha-1.js" > </script>
    <script src="jquery-ui-amd-1.8.16-alpha-1.js" > </script>
    <script src="createjs-1.0.0alpha1.js" > </script>
    
    <script>
        jQuery(document).ready(function() {
        jQuery('body').midgardCreate({
          url: function() { return '/some/backend/url'; },
          stanbolUrl: '/'
        });
      });
    </script>
  </head>

  <body>
    <h1>Sioc Post</h1>
    <div typeof="sioc:Post" about="./node" > 
        <div property="sioc:title"><@ldpath path="sioc:title"/></div>
        <div property="sioc:content"><@ldpath path="sioc:content"/></div>
    </div>
  </body>
</html>

