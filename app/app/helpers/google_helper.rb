module GoogleHelper

	# Método que cria um google maps para usar o marker para pegar o localatual
	#
    # === Parametros
    # - id:: 		String		id da div do mapa
	# - lat:: 		Float		latitude do marcador
	# - lng:: 		Float		longitude do marcardo
	# - label:: 		String		descrição do mapa
	# - function:: 	String		função pelo qual será retornado o marcador
	# - height::		Int/String	altura do mapa
	# - width::		Int/String	largura do mapa
	# - zoom::		Int 		nivel do zoom
	# - draggable:: 	Boolean		Se é ou não possível modificar o marker
	# - icon:: 		String		Icone para o label
	# - image::		String		Imagem para o marcador
	def google_marker_map id, lat=-31.78172685720895, lng=-52.322816723754784, label="mapa", function="markerChange", disable=false, height="200px", width="100%", zoom=6, draggable="true", icon="maps:place", image=nil
		if lat == '' or lat == nil
			lat= -31.78172685720895
		end
		if lng == '' or lng == nil
			lng= -52.322816723754784
		end
		id.gsub!(/[^0-9A-Za-z]/, "")
		google_maps_api = System::Config.first.google_maps_id
		app_helper_google_not_defined = t "app_helper_google_not_defined"
		retorno = "
				    <script async defer src=\"http://maps.googleapis.com/maps/api/js?key=#{google_maps_api}&v=3&callback=initialize\">
				    </script>
					<div class='row'>
						<div class='col s12'>
							<div style='height:#{height}; width:#{width}; margin-top:10px' id='#{id}'></div>
							<script>
								var image = '#{image}';
								var map;
                                var marker;
								function initialize() {
									var myLatLng = {lat: #{lat}, lng: #{lng} };
								  var mapOptions = {
								    zoom: #{zoom},
								    center: myLatLng
								  };
								  map = new google.maps.Map(document.getElementById('#{id}'),
								      mapOptions);
								  marker = new google.maps.Marker({
								    position: map.getCenter(),
								    map: map,
								    title: '#{label}',
								    icon: image,
                                    animation: google.maps.Animation.DROP,
								    draggable:#{draggable}
								  });
								  google.maps.event.addListener(marker, 'position_changed', function() {
								  	if(typeof(#{function}) == 'function') {
								  		#{function}(marker);
								  	}else{
								  		console.log('#{app_helper_google_not_defined}')
								  	}

								  });
								}
								$(document).ready(function(){
                                    $('ul.tabs').on('click', 'a', function(e) {
                                        google.maps.event.trigger(map, 'resize');
                                    });
								});
							</script>
						</div>
					  </div>"
		retorno.html_safe
	end

end
