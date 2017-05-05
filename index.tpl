<!doctype html>
<head>
    <meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>KHCC images</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

    <script type="text/javascript" language="javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

	<script type="text/javascript" charset="utf-8">
		function get_selected() {
			var selected = $("#address_select").val()
			if( /[\d\-]+/.test(selected)==false ) {
				return null
			} else {
				return selected
			}
		}

	
		function random_pick() {
			var size = $('#address_select option').size()
			var index = Math.floor(Math.random() * size) + 1  
			$('#address_select option').eq(index).prop('selected', true);
			
			var val = $('#address_select option').eq(index).val()
			window.history.pushState("", "", val);
		}


		function get_images() {
			var address = window.location.pathname.slice(1)
			if( address == null ) {
				$("#images").text("ERROR!")
			} else {
                $.ajax({
                    url:"/images/"+address
                }).done(function(data){
					$("#images").html(data)
                })
			}
		}


		$(document).ready(function() {
			var pathname = window.location.pathname

			if(pathname == "/") {
				random_pick()
			} else {
				var house_id = window.location.pathname.slice(1)
				$('#address_select').val(house_id)
			}
			
			get_images()

			$("#address_select").change(function(){
				var address = get_selected()
				window.history.pushState("", "", address);
				get_images()
			})
		});

	</script>
</head>
<body>
	<div class="container">
		<p>Release: {{heroku_release}}</p>
		Address:&nbsp;<select id="address_select">
			% if len(addresses) > 0:
				%for address in addresses:
				<option value="{{address}}">{{address}}</option>
				%end
			% else:
				<option value="">No data available</option>
			% end
		</select>
		<div id=images></div>
	</div>
</body>
</html>
