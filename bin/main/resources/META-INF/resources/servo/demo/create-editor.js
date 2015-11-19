// Prepare VIE
//var v = new VIE();
//v.use(new v.RdfaService());

/*
jQuery(document).ready(function() {
	jQuery('body').midgardCreate({
		url: function() { return '/some/backend/url'; },
			stanbolUrl: '/'
	});
}); 
*/


jQuery(document).ready(function() {
  // Instantiate Create
  jQuery('body').midgardCreate({
  	//vie: v,
    url: function() {
      return 'javascript:false;';
    },
    // Use Aloha for all text editing
    editorWidgets: {
     'default': 'aloha'
    },
    editorOptions: {
      aloha: {
        widget: 'alohaWidget'
      }
    },
    collectionWidgets: {
     'default': null,
      'feature': 'midgardCollectionAdd'
    },
    tags: true,
    toolbar:'full',
    stanbolUrl: '/' 
});

  // Fake Backbone.sync since there is no server to communicate with
 Backbone.sync = function(method, model, options) {
  if (console && console.log) {
   console.log('Model contents', model.toJSONLD());
 }
  options.success(model);
};
});
