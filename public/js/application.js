$('document').ready(function(){

	function initialize(position){
		var latitude = position.coords.latitude;
		var longitude = position.coords.longitude;
		$('#new_clock_in_event').append("<input type='hidden' name='latitude' value=" + latitude + ">")
		$('#new_clock_in_event').append("<input type='hidden' name='longitude' value=" + longitude + ">")

	}

	function initCoords(){
	  if (navigator.geolocation) {
	    navigator.geolocation.getCurrentPosition(initialize);
	  } else {
	    showError("Your browser does not support Geolocation!");
	  }
	}

	var map_options = {
		center: new google.maps.LatLng(-34.397, 150.644),
  		zoom: 8
	}

	$('#datepicker').datepicker({ altFormat: "yy-mm-dd", altField: '#datepicker' });
	$('#to').datepicker({ altFormat: "yy-mm-dd", altField: '#to', showOn: 'button' });
	$('#from').datepicker({ altFormat: "yy-mm-dd", altField: '#from', showOn: 'button' });

	$('.edit_form').dialog({ 
		appendTo: '.job_clock_ins',
		title: 'Edit Clock In/Out',
		buttons: [
			{
				text: 'Cancel',
				click: function(){
					$(this).dialog('Close');
				}
			}
		],
		modal: true,
		autoOpen: false
		 })

	$('.edit_ci').on('click', function(e){
		e.preventDefault();
		form_id = $(this).data('id')
		$('#ci_edit_' + form_id).dialog('open')
	})


	initCoords();
})



