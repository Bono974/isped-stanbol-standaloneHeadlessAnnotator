<@namespace ont="http://example.org/service-description#" />
<@namespace ehub="http://stanbol.apache.org/ontology/entityhub/entityhub#" />
<@namespace cc="http://creativecommons.org/ns#" />
<@namespace dct="http://purl.org/dc/terms/" />
<@namespace sioc="http://rdfs.org/sioc/ns#" />
<!DOCTYPE html>
<html xmlns:sioc="http://rdfs.org/sioc/ns#">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" href="lib/jquery/jquery-ui.min.css" />
    <link rel="stylesheet" href="lib/Smoothness/jquery.ui.all.css" />
    <link rel="stylesheet" href="annotate.css" />

    <script type="text/javascript" src="lib/jquery/jquery-1.8.2.js"></script>
    <!--<script type="text/javascript" src="lib/jquery-ui.1.9m5.js"></script>-->

    <script type="text/javascript" src="lib/jqueryui/jquery-ui.1.10.2.min.js"></script>
    <!--
      <script type="text/javascript" src="lib/jqueryui/jquery-ui.1.8.24.js"></script>
    -->
    <script type="text/javascript" src="lib/underscore-min.js"></script>
    <script type="text/javascript" src="lib/backboneJS/backbone.js"></script>

    <script type="text/javascript" src="lib/hallo/hallo.js"></script>
    <script type="text/javascript" src="lib/hallo/format.js"></script>

    <script type="text/javascript" src="lib/jquery.rdfquery.debug.js"></script>
    <script type="text/javascript" src="lib/vie/vie.js"></script>


    <script type="text/javascript" src="lib/vie.entitypreview.js"></script>
    <script type="text/javascript" src="lib/annotate.js"></script>

    <script>
    if (window.JSON === undefined ) { 
        document.write('<' + 'script src="lib/json/json2.js">/script>"></' + 'script>');
    }
    $(document).ready(function(){ _.defer(function(){
        var stanbolUrl = "http://localhost:8081";
        $('#loadingDiv')
        .hide()  // hide it initially
        .ajaxStart(function() {
            $(this).show();
        })
        .ajaxStop(function() {
            $(this).hide();
        });
        function getChain(){
            return $("#chain").val();
        }

        // Whenever the chain selector changes, tell annotate.js about it.
        $("#chain").bind('change', function (e) {
            var z = new VIE();
            var chain = getChain();
            z.use(new z.StanbolService({
                // remove "/enhancervie" or "/enhancervie/" from the end of the uri.
                // it.publicBaseUri gives back http://localhost:8080 or so if redirected so it's not useful.
                url: stanbolUrl,
                enhancer: {chain: chain}
            }));

            $('.content').annotate('option', 'vie', z);
            var state = $('.enhanceButton').prop('checked');
            if (state) {
                $('.content').annotate('disable');
                _.defer(function(){
                    $('.content').annotate('enable');
                });
            }
        });

        // make the content element editable
        $('.content').hallo({
            plugins: {
//              'halloformat': {}
            },
            editable: true
        });
        function enable(){
            $('.content')
            .each(function(){
                $(this)
                .annotate('enable', function(success){
                    if(success){
                        $('.enhanceButton')
                        .button('enable')
                        .button('option', 'label', 'Done');

                        $('.acceptAllButton')
                        .show()
                        .button('enable')
                    } else {
                        $('.enhanceButton')
                        .button('enable')
                        .button('option', 'label', 'error, see the log.. Try to enhance again!');
                    }
                });
            });
        }

        function instantiate(){
            var z = new VIE();
            z.use(new z.StanbolService({
                url : stanbolUrl
                // enhancer: {chain: getChain()}
            }));
            $('.content').annotate({
                vie: z,
                // typeFilter: ["http://dbpedia.org/ontology/Place", "http://dbpedia.org/ontology/Organisation", "http://dbpedia.org/ontology/Person"],
                debug: true,
                continuousChecking: true,
                //autoAnalyze: true,
                showTooltip: true,
                decline: function(event, ui){
                    console.info('decline event', event, ui);
                },
                select: function(event, ui){
                    console.info('select event', event, ui);
                },
                remove: function(event, ui){
                    console.info('remove event', event, ui);
                },
                success: function(event, ui){
                    console.info('success event', event, ui);
                },
                error: function(event, ui){
                    console.info('error event', event, ui);
                    alert(ui.message);
                }
            });
        }
        instantiate();

        $('.acceptAllButton')
        .button()
        .hide()
        .click(function(){
            $('.content')
            .each(function(){
                $(this)
                .annotate('acceptAll', function(report){
                    console.log('AcceptAll finished with the report:', report);
                });
            })
            $('.acceptAllButton')
            .button('disable');
        });

        $('.enhanceButton')
        .button()
        .change(function(e){
            var button = $(e.target);
            var state = button.prop('checked');
            $('.enhanceButton').prop('checked', state).button('refresh');

            if(state){
                $('.enhanceButton').button('option', 'label', 'Done');
                enable();
                $('.acceptAllButton')
                .show();
            } else {
                // annotate.disable()
                $('.content').annotate('disable');
                $('.enhanceButton').button('option', 'label', 'Annoter le texte !');
                $('.acceptAllButton')
                .hide();
            }

        });

        function getChains(stanbolUri, cb) {
            var query = "PREFIX enhancer: <http://stanbol.apache.org/ontology/enhancer/enhancer#> \n" +
                    "PREFIX rdfs:     <http://www.w3.org/2000/01/rdf-schema#> \n" +
                    "SELECT distinct ?name ?chain " +
                    "WHERE { " +
                    "?chain a enhancer:EnhancementChain. \n" +
                    "?chain rdfs:label ?name .\n" +
                    "} " +
                    "ORDER BY ASC(?name) ";

            function success(res) {
                var chains = $('binding[name=name] literal', res).map(function () {
                    return this.textContent;
                }).toArray();
                if (_(chains).indexOf('default') != -1) {
                    chains = _.union(['default'], chains);
                }
                cb(null, chains);
            }

            function error(xhr) {
                cb(xhr);
            }

            var uri = stanbolUri + "/enhancer/sparql";

            $.ajax({
                type: "POST",
                url: uri,
                data: {query: query},
                // accepts: ["application/json"],
                accepts: {'application/json': 'application/sparql-results+json'},
                // dataType: "application/json",
                success: success,
                error: error
            });
            // var xhr = $.getJSON(uri,success);xhr.error(error);
        }

        function fillChainList(cb) {
            var v = new VIE();
            v.use(new v.StanbolService({url: stanbolUrl}));
            getChains(stanbolUrl, function (err, chains) {
                if (err) {
                    console.info(err);
                    $('#chain').html("<option>Error loading chains</option>");
                    $('#error').html('Error loading list of chains from ' + stanbolUrl);
                } else {
                    console.info('Chains:', chains);
                    $('#chain').html('');
                    for (i in chains) {
                        var chain = chains[i];
                        $('#chain').append("<option value='" + chain + "'>" + chain + "</option>");
                    }
                    cb();
                }
            });

        }
        // Fill in the chain list, then initialize the annotate.js widget.
        fillChainList(instantiate);

        jQuery('.instantiate').button().click(instantiate);
        jQuery('.destroy').button().click(function(){
            jQuery('.content').annotate('destroy');
        });
        jQuery('.enable').button().click(function(){
            enable();
        });
        jQuery('.disable').button().click(function(){
            jQuery('.content').annotate('disable');
        });
        jQuery('.listDom').button().click(function(){
            alert(jQuery('.content')[0].outerHTML);
        });
    });});
    </script>
  </head>
  <body  xmlns:sioc     = "http://rdfs.org/sioc/ns#"
         xmlns:skos     = "http://www.w3.org/2004/02/skos/core#"
         xmlns:schema   = "http://schema.org/">
        <div class="panel" id="webview">
            <h2>ServO endpoint annotator</h2>
            <div>
                <label>
                    Enhancement chain:
                    <select id="chain" value="default">
                        <option>not loaded yet</option>
                    </select>
                </label>
            </div>
            <input type="checkbox" class="enhanceButton" id="enhanceButton1" /><label for="enhanceButton1">Annoter le texte !</label>
            <button class="acceptAllButton" style="display:none;">Tout valider ?</button>
            <article typeof="schema:CreativeWork" about="http://stanbol.apache.org/enhancertest">
                <div property="sioc:content" class="content"></div>
            </article>
        </div>
        <div id="loadingDiv" style="display:none;"><img src="spinner.gif"/></div>
    </body>
</html>
