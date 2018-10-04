$(document).ready(function()  {

//CONFIGURATION

	var location = window.location.pathname.split('/');
	var socket = io.connect('http://127.0.0.1:5000');

	socket.on('error', (err) => {
        console.log('Error connecting to server', err);
    });

    socket.on('disconnect', () => {
        console.log('Disconnect from server');
    });

    socket.on('reconnect', (number) => {
        console.log('Reconnected to server', number);
    });

    socket.on('reconnect_attempt', () => {
        console.log('Reconnect Attempt');
    });

    socket.on('reconnecting', (number) => {
        console.log('Reconnecting to server', number);
    });

    socket.on('reconnect_error', (err) => {
        console.log('Reconnect Error', err);
    });

    socket.on('reconnect_failed', () => {
        console.log('Reconnect failed');
    });

    socket.on('connect_error', () => {
        console.log('connect_error');
    });
	

    socket.on('connect', function() {
        console.log('Websocket connected!');
    });

    socket.on('disconnect', function() {
        console.log('Websocket disconnected!');
    });

//GET LOCATION

	if (location[1] == 'profile') {

		function showError(error) {
		    ipLookUp();
		}

		MyFunction = function (position) {
				
			$.ajax('http://ip-api.com/json')
		  	.then(
		      function success(response) {

		      	var backup_lat = response.lat;
		      	var backup_lon = response.lon;

		      	$.ajax({
		      		url : "/location",
		      		type : 'POST',
		      		data : {
		      			latitude : position.coords.latitude,
		      			longitude : position.coords.longitude,
		      			backup_lat : backup_lat,
		      			backup_lon : backup_lon
	      			}
	      		})
		      },

		      function fail(data, status) {
			          console.log('Request failed.  Returned status of', status);
			      }
			  );
		}
			    
		if (navigator.geolocation) {
	        navigator.geolocation.getCurrentPosition(MyFunction, showError);
	    } else { 
	        alert("Geolocation is not supported by this browser.");
	    }

	    function ipLookUp () {
		  $.ajax('http://ip-api.com/json')
		  .then(
		      function success(response) {

		      	$.ajax({
		      		url : "/location",
		      		type : 'POST',
		      		data : {
		      			latitude : response.lat,
		      			longitude : response.lon,
		      			backup_lat : response.lat,
		      			backup_lon : response.lon
		      		}
		      	})
		      },

		      function fail(data, status) {
		          console.log('Request failed.  Returned status of', status);
		      }
		  );
		}

		socket.on('connect', function () {
	        var current_user_id = $('#current_user_id').val();
	        var current_user = $('#current_user').val();
	        if (current_user != location[2]) {
		        socket.emit( 'profile check', {
		        	visitor_name : current_user,
		        	visitor_id : current_user_id,
		            host_name : location[2],
		            message: current_user+" checked your profile"
		        })
		    }
		})
	}

	socket.on( 'profile response', function( msg ) {
	var current_user = $('#current_user').val();
	if(msg.host_name == current_user && msg.message != 'false') {
	    $( '#notification-box' ).append('<div class="alert alert-success show fade alert-dismissible float-right" role="alert">'+msg.message+'<button type="button" class="close" data-dismiss="alert" aria-label="Close" value="'+msg.message+'"><span aria-hidden="true">&times;</span><input value="'+msg.message+'" hidden></button></div>' )
	  }
	})

//EDIT PROFILE FORMS

	$('#basic_info_form').on('submit', function(event) {

		$.ajax({
			data : {
				gender : $('#gender').val(),
				day : $('#day').val(),
				month : $('#month').val(),
				year : $('#year').val(),
				looking_for : $('#looking_for').val(),
				min_age : $('#min_age').val(),
				max_age : $('#max_age').val()
			},
			type: 'POST',
			url: '/save-basic-info'
		})
		.done(function(data) {

			if (data.error) {
				$('#errorAlertBasic').text(data.error).show();
				$('#successAlertBasic').hide();
			}
			else {
				$('#successAlertBasic').text(data.success).show();
				$('#errorAlertBasic').hide();
			}
		});

		event.preventDefault();
	});

	$('#location_form').on('submit', function(event) {

		$.ajax({
			data : {
				city : $('#city').val(),
				district : $('#district').val()
			},
			type: 'POST',
			url: '/save-user-location'
		})
		.done(function(data) {

			if (data.error) {
				$('#errorAlertLocation').text(data.error).show();
				$('#successAlertLocation').hide();
			}
			else {
				$('#successAlertLocation').text(data.success).show();
				$('#errorAlertLocation').hide();
			}
		});

		event.preventDefault();
	});

	$('#appearance_form').on('submit', function(event) {

		$.ajax({
			data : {
				height : $('#height').val(),
				body_type : $('#body_type').val(),
				hair_color : $('#hair_color').val(),
				eye_color : $('#eye_color').val(),
				hair_type : $('#hair_type').val(),
			},
			type: 'POST',
			url: '/save-appearance'
		})
		.done(function(data) {

			if (data.error) {
				$('#errorAlertAppearance').text(data.error).show();
				$('#successAlertAppearance').hide();
			}
			else {
				$('#successAlertAppearance').text(data.success).show();
				$('#errorAlertAppearance').hide();
			}
		});

		event.preventDefault();
	});

	$('#lifestyle_form').on('submit', function(event) {

		$.ajax({
			data : {
				relationship_status : $('#relationship_status').val(),
				children : $('#children').val(),
				would_like_children : $('#would_like_children').val(),
				diet : $('#diet').val(),
				drinking : $('#drinking').val(),
				smoking : $('#smoking').val(),
			},
			type: 'POST',
			url: '/save-lifestyle'
		})
		.done(function(data) {

			if (data.error) {
				$('#errorAlertLifestyle').text(data.error).show();
				$('#successAlertLifestyle').hide();
			}
			else {
				$('#successAlertLifestyle').text(data.success).show();
				$('#errorAlertLifestyle').hide();
			}
		});

		event.preventDefault();
	});

	$('#background_form').on('submit', function(event) {

		$.ajax({
			data : {
				education : $('#education').val(),
				employment : $('#employment').val(),
				occupation : $('#occupation').val(),
				languages : $('#languages').val(),
			},
			type: 'POST',
			url: '/save-background'
		})
		.done(function(data) {

			if (data.error) {
				$('#errorAlertBackground').text(data.error).show();
				$('#successAlertBackground').hide();
			}
			else {
				$('#successAlertBackground').text(data.success).show();
				$('#errorAlertBackground').hide();
			}
		});

		event.preventDefault();
	});

	$('#description_form').on('submit', function(event) {

		$.ajax({
			data : {
				about_me : $('#about_me').val(),
				about_target : $('#about_target').val(),
			},
			type: 'POST',
			url: '/save-description'
		})
		.done(function(data) {

			if (data.error) {
				$('#errorAlertDescription').text(data.error).show();
				$('#successAlertDescription').hide();
			}
			else {
				$('#successAlertDescription').text(data.success).show();
				$('#errorAlertDescription').hide();
			}
		});

		event.preventDefault();
	});

	$('.tag_button').on('click', function() {

		$.ajax({
			data : {
				tag: $(this).val()
			},
			type: 'POST',
			url: '/add_interests',
		})

		$('#chosen_interests').append("<button class='btn btn-warning tag_button_chosen' value='" + $(this).val() + "'>#" + $(this).val() + " </button>   ");
	});

	$(document).on('click', '.tag_button_chosen', function() {

		$.ajax({
			data : {
				tag: $(this).val()
			},
			type: 'POST',
			url: '/remove_interests',
		})

		$(this).remove();
	});

//PICTURES

	$('#profile_picture').on('submit', function(event) {

		var form_data = new FormData($('#profile_picture')[0]);
		$.ajax({
			data : form_data,
			type: 'POST',
			url: '/upload-profile-pic',
			contentType: false,
            cache: false,
            processData: false,
		})
		.done(function(data) {

			if (data.error) {
				$('#errorAlertProfilePic').text(data.error).show();
				$('#successAlertProfilePic').hide();
			}
			else {
				$('#successAlertProfilePic').text(data.success).show();
				$('#errorAlertProfilePic').hide();
			}
		});

		event.preventDefault();
	});

	$('#upload_pic').click(function() {

		$('#upload_pic_button').removeAttr('disabled');
		
	});

	var dragHandler = function(evt){
        evt.preventDefault();
    };

    var dropHandler = function(evt){
	    evt.preventDefault();
	    var files = evt.originalEvent.dataTransfer.files;

	    var formData = new FormData();
	    for (var i = 0; i <= files.length - 1; i++) {
	    	formData.append("file", files[i]);
	    }

	    $.ajax({
	    	url: "/dropzone",
	        method: "POST",
	        processData: false,
	        contentType: false,
	        data: formData,
	    })
	    .done(function(data) {

			if (data.error) {
				$('#errorAlertDropzone').text(data.error).show();
				$('#successAlertDropzone').hide();
			}
			else {
				$('#successAlertDropzone').text(data.success).show();
				$('#errorAlertDropzone').hide();
			}
		});
	};

    var dropHandlerSet = {
        dragover: dragHandler,
        drop: dropHandler
    };

    $("#myDropzone").on(dropHandlerSet);

    $('#user_gallery').on('show.bs.modal', function (event) {
	  	var button = $(event.relatedTarget)
	 	var recipient = button.data('whatever')
	  	var modal = $(this)
	  	modal.find('.modal-body img').attr('src', recipient)
	  	$('#delete_pic').on('click', function() {
	  		var answer = confirm("Are you totally 1000% sure?");
	  		if (answer == true) {
	  			var picture = modal.find('.modal-body img').attr('src').slice(3);
	  			$.ajax({
					data : {
						username : location[2],
						picture : picture
					},
					type: 'POST',
					url: '/delete-pic',
				})
				window.location.replace(location[2]);
	  		}
	 	});
	})


//ACCOUNT SETTINGS

	$('#change_account').on('submit', function(event) {

		$.ajax({
			data : {
				name : $('#name').val(),
				lastname : $('#lastname').val(),
				username : $('#username').val(),
				email : $('#email').val(),
			},
			type: 'POST',
			url: '/save-account-info'
		})
		.done(function() {
			window.location.replace("/");
		})
		event.preventDefault();
	});

	$('#delete_account').click(function() {

		var answer = confirm("Are you totally 1000% sure?");

		if (answer == true) {
			$.ajax({
			data : {
				username : location[2]
			},
			type: 'POST',
			url: '/delete-account',
		})
		}

		window.location.replace("/");

	});

//LIKE, DISLIKE, CONNECTION

	if (value = $('#like-button div').text() == "LIKED") {
		var clicked = false;
	} else {
		var clicked = true;
	}

	socket.on( 'like response', function( msg ) {
		var current_user = $('#current_user').val();
	    if (msg.host_name == current_user && msg.message != 'false') {
	    	$('#notification-box').append('<div class="alert alert-success show fade alert-dismissible float-right" role="alert">'+msg.notification+'<button type="button" class="close" data-dismiss="alert" aria-label="Close" value="'+msg.notification+'"><span aria-hidden="true">&times;</span><input value="'+msg.notification+'" hidden></button></div>' )
	    }
	})

	socket.on( 'dislike response', function( msg ) {
		var current_user = $('#current_user').val();
	    if (msg.host_name == current_user && msg.message != 'false') {
	    	$('#notification-box').append('<div class="alert alert-danger show fade alert-dismissible float-right" role="alert">'+msg.notification+'<button type="button" class="close" data-dismiss="alert" aria-label="Close" value="'+msg.notification+'"><span aria-hidden="true">&times;</span><input value="'+msg.notification+'" hidden></button></div>' )
	    	$('#start-chat-button').remove();
	    }
	})

	socket.on( 'connection response', function( msg ) {
		var current_user = $('#current_user').val();
	    if (msg.host_name == current_user && msg.message != 'false') {
	    	$('#notification-box').append('<div class="alert alert-success show fade alert-dismissible float-right" role="alert">'+msg.notification+'<button type="button" class="close" data-dismiss="alert" aria-label="Close" value="'+msg.notification+'"><span aria-hidden="true">&times;</span><input value="'+msg.notification+'" hidden></button></div>' )
	    	$('#start-chat').html('<a id="start-chat-button" class="btn btn-success" href="/chats/'+msg.host_name+'" role="button">START CHAT</a>');
	    }
	})

	$('#like-button').click(function() {

		var value = $('#like-button div').text();

		if(clicked){
	        $(this).html('<button id="liked-button" class="btn btn-danger">LIKED</button>')
	        $.ajax({
				data : {
					username : location[2]
				},
				type: 'POST',
				url: '/save-like',
			})
			.done(function() {

		        var current_user_id = $('#current_user_id').val();
		        var current_user = $('#current_user').val();
		        socket.emit( 'like event', {
		        	visitor_name : current_user,
		        	visitor_id : current_user_id,
		            host_name : location[2],
		            notification : current_user+" liked your page"
		        })

				$.ajax({
		    		data : {
						username : location[2]
					},
					type: 'POST',
					url: '/check-mutual',
				})
				.done(function(data) {
					if (data.value == 'True') {
						$('#start-chat').html('<a id="start-chat-button" class="btn btn-success" href="/chats/'+location[2]+'" role="button">START CHAT</a>');

				        var current_user_id = $('#current_user_id').val();
				        var current_user = $('#current_user').val();
				        socket.emit( 'connection event', {
				        	visitor_name : current_user,
				        	visitor_id : current_user_id,
				            host_name : location[2],
				            notification : "you got a new connection with "+current_user
				        })
					}
					else {
						$('#start-chat-button').remove();
					}
				});	
			}); 
	        clicked  = false;
	    } else {
	        $(this).html('<button id="like-button" class="btn btn-outline-danger">LIKE</button>')
	        $('#start-chat-button').remove();
	        $.ajax({
				data : {
					username : location[2]
				},
				type: 'POST',
				url: '/delete-like',
			})
			.done(function() {

		        var current_user_id = $('#current_user_id').val();
		        var current_user = $('#current_user').val();
		        socket.emit( 'dislike event', {
		        	visitor_name : current_user,
		        	visitor_id : current_user_id,
		            host_name : location[2],
		            notification : current_user+" disliked your page :("
		        })
			});
	        clicked = true;
	    }
	});

//USER INTERACTION

	$('#report_user').click(function() {

		$.ajax({
			data : {
				username : location[2]
			},		
			type: 'POST',
			url: '/report-user',
		})
		.done(function(data) {

			if (data.error) {
				$('#errorAlertReport').text(data.error).show();
				$('#successAlertReport').hide();
			}
			else {
				$('#successAlertReport').text(data.success).show();
				$('#errorAlertReport').hide();
			}
		});
	});

	$(document).on('click', '#block-user', function() {
		$.ajax({
			data : {
				username : location[2]
			},		
			type: 'POST',
			url: '/block-user',
		})
		.done(function(data) {

			if (data.error) {
				$('#errorAlertReport').text(data.error).show();
				$('#successAlertReport').hide();
			}
			else {
				$('#successAlertReport').text(data.success).show();
				$('#errorAlertReport').hide();
			}

			setTimeout(function(){ window.location.replace("/"); }, 2000);
		});
	});

	$(document).on('click', '#unblock-user', function() {

		$.ajax({
			data : {
				username : location[2]
			},		
			type: 'POST',
			url: '/unblock-user',
		})
		.done(function(data) {

			if (data.error) {
				$('#errorAlertReport').text(data.error).show();
				$('#successAlertReport').hide();
			}
			else {
				$('#successAlertReport').text(data.success).show();
				$('#errorAlertReport').hide();
			}

			$("#blocking").html('<div id="block-user" class="btn btn-info">BLOCK USER</div>')
		});
	});

//NOTIFICATIONS

	$('#notification_form').on('submit', function(event) {

		$.ajax({
			data : {
				profile_check : $('#profile_check').prop('checked'),
				new_like : $('#new_like').prop('checked'),
				new_unlike : $('#new_unlike').prop('checked'),
				new_connection : $('#new_connection').prop('checked'),
				new_message : $('#new_message').prop('checked')
			},
			type: 'POST',
			url: '/save-settings'
		})
		.done(function(data) {

			if (data.error) {
				$('#errorAlertNotifications').text(data.error).show();
				$('#successAlertNotifications').hide();
			}
			else {
				$('#successAlertNotifications').text(data.success).show();
				$('#errorAlertNotifications').hide();
			}
		});

		event.preventDefault();
	});

//CHAT

	socket.on( 'my response', function( msg ) {
		var current_user = $('#current_user').val();
		var d = new Date();
		var time_n = d.toLocaleTimeString('en-GB', {weekday: 'short', hour: '2-digit', minute:'2-digit'});
		var node_time = document.createTextNode(time_n)
		var message = document.createTextNode(": "+msg.message)
		var sender_name = document.createTextNode(msg.sender_name)
		var outer_div = document.createElement('div')
		outer_div.className = "m-1"
		var inner_div = document.createElement('div')
		inner_div.className = "float-left text-message"
		var bold = document.createElement('b')
		bold.className = "text-success"
		var time = document.createElement('div')
		time.className = "float-right text-lowercase text-muted"
		var clearfix = document.createElement('div')
		clearfix.className = "clearfix"

		if (msg.message !== '' && msg.message != 'false' && ((msg.recieve_name == current_user && msg.sender_name == location[2]) || (msg.sender_name == current_user && msg.recieve_name == location[2]))) {
		    if (msg.sender_name == current_user) {
		    	bold.appendChild(sender_name)
				inner_div.appendChild(bold)
				inner_div.appendChild(message)
				time.appendChild(node_time)
				outer_div.appendChild(inner_div)
				outer_div.appendChild(time)
				outer_div.appendChild(clearfix)
			    $( 'div.message_holder' ).prepend(outer_div)
			} else {
				bold.className = "text-info"
				bold.appendChild(sender_name)
				inner_div.appendChild(bold)
				inner_div.appendChild(message)
				time.appendChild(node_time)
				outer_div.appendChild(inner_div)
				outer_div.appendChild(time)
				outer_div.appendChild(clearfix)

				$( 'div.message_holder' ).prepend(outer_div)
			}
		    if (msg.recieve_name == current_user && location[1] != 'chats') {
		    	$( '#notification-box' ).append('<div class="alert alert-success show fade alert-dismissible float-right" role="alert">'+msg.notification+'<button type="button" class="close" data-dismiss="alert" aria-label="Close" value="'+msg.notification+'"><span aria-hidden="true">&times;</span><input value="'+msg.notification+'" hidden></button></div>' )
		    }
		}
	})

    $('#message_form').on( 'submit', function(e) {
        var current_user_id = $('#current_user_id').val();
        var current_user = $('#current_user').val()
        e.preventDefault()

        var user_input =  $('.message').val();
        socket.emit( 'my event', {
        	sender_name : current_user,
        	sender_id : current_user_id,
            recieve_name : location[2],
            message : user_input,
            notification : "you got a new message from " + current_user,
            is_chats : location[1]
        })
        $('.emoji-wysiwyg-editor').html('').focus()
    })

    $('#message_form').keypress(function(e) {
    	if (e.keyCode == '13') {
	        var current_user_id = $('#current_user_id').val();
	        var current_user = $('#current_user').val()
	        e.preventDefault()

	        var user_input =  $('.message').val();
	        if (user_input == "") {
	        	user_input =  $('.message').text();
	        }
	        socket.emit( 'my event', {
	        	sender_name : current_user,
	        	sender_id : current_user_id,
	            recieve_name : location[2],
	            message : user_input,
	            notification : "you got a new message from " + current_user,
	            is_chats : location[1]
	        })
        	$('.emoji-wysiwyg-editor').html('').focus()       
	    }
    })

	$(document).on('click', '.close', function() {

		$.ajax({
			data : {
				message : $(this).val(),
				current_user_id : $('#current_user_id').val()
			},
			type: 'POST',
			url: '/delete-notification'
		})
	});

//FILTERS

	$('.recommend-filter').on('click', function() {
		var current = window.location.href.toLowerCase()
		if (current.indexOf("sort_by=") != -1) {
			var new_current = current.substring(0, current.indexOf("sort_by=") - 1)
			if (new_current.indexOf('?') != -1) {
				window.location.replace(new_current + "&sort_by=" + $(this).val())
			}
			else {
				window.location.replace(new_current + "?sort_by=" + $(this).val())
			}
		}
		else {
			if (current.indexOf('?') != -1) {
				window.location.replace(current + "&sort_by=" + $(this).val())
			}
			else {
				window.location.replace(current + "?sort_by=" + $(this).val())
			}
		}
	});

	$('#age_filter').on('click', function() {
		var min_age = $('#min_age').val()
		var max_age = $('#max_age').val()
		var min_fame = $('#min_fame').val()
		var max_fame = $('#max_fame').val()
		var max_location = $('#max_location').val()
		var max_interests = $('#max_interests').val()

		if (min_age == "" || $.isNumeric(min_age) == false) {
			min_age = 20
		}

		if (max_age == "" || $.isNumeric(max_age) == false) {
			max_age = 50
		}

		if (min_fame == "" || $.isNumeric(min_fame) == false) {
			min_fame = 0
		}

		if (max_fame == "" || $.isNumeric(max_fame) == false) {
			max_fame = 1
		}

		if (location[1] == 'recommendations' && $.isNumeric(max_fame) == false) {
			max_interests = 1
		}

		if (!max_interests) {
			max_interests = ""
		}

		var interests = $('.interest_button_chosen')

		interests.each(function () {
			max_interests += $(this).val()+"+"
		})

		var current = window.location.href.toLowerCase()
		var path = current

		if (current.indexOf('?') != -1) {
			var new_current = current.substring(0, current.indexOf("?"))
			path = new_current
		}

		window.location.replace(path + "?min_age=" + min_age + "&max_age=" + max_age + "&min_fame=" + min_fame + "&max_fame="
								+ max_fame + "&max_location=" + max_location
								+ "&max_interests=" + max_interests)
	});

	$('.search-interests').on('click', function() {
			$('#interest_holder').append("<button class='btn btn-warning interest_button_chosen' value='" + $(this).val() + "'>#" + $(this).val() + " </button>    ");
		})


	$(document).on('click', '.interest_button_chosen', function() {
		$(this).remove();
	});

	window.emojiPicker = new EmojiPicker({
		emojiable_selector: '[data-emojiable=true]',
		assetsPath: '/static/img',
		popupButtonClasses: 'fa fa-smile-o'
	});
	window.emojiPicker.discover();

});