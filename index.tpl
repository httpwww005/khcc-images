<!doctype html>
<head>
    <meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>KHCC images</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

    <script type="text/javascript" language="javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

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
		}


		$(document).ready(function() {
			random_pick()

			var address = get_selected()

			if( address == null ) {
				$("#images").text("ERROR!")
			} else {
                $.ajax({
                    url:"/images/"+address
                }).done(function(data){
					$("#images").html(data)
                })
			}

			$("#address_select").change(function(){
				var address = get_selected()
				if( address != null ) {
					$.ajax({
						url:"/images/"+address
					}).done(function(data){
						$("#images").html(data)
					})

				}
			})
		});


	</script>

</head>
<body>
	<div class="container">
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
