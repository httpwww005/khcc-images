<div class = "row">
	<hr>
	<div>
		% if len(images) > 0:
			% for image in images:
				<div class = "col-sm-6 col-md-3">
					<a href="http://imgur.com/download/{{image["id"]}}" class="thumbnail" target="_blank"><img src="http://i.imgur.com/{{image["id"]}}.jpg" alt="Generic placeholder thumbnail" /></a>
				</div>
			% end
		% end

		% if len(gdimages) > 0:
			% for image in gdimages:
				<div class = "col-sm-6 col-md-3">
					<a href="http://drive.google.com/uc?export=download&id={{image["drive_id"]}}" class="thumbnail" target="_blank"><img src="http://drive.google.com/uc?export=download&id={{image["drive_id"]}}" alt="Generic placeholder thumbnail" /></a>
				</div>
			% end
		% end
	</div>
</div>
