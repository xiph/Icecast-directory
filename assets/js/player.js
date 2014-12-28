var mediaElement = jQuery("#player").get(0);
var nowPlaying = jQuery("#nowplaying");

jQuery(".streamentry").html(function() {
	if (mediaElement.canPlayType(jQuery(this).data("contenttype"))) {
		jQuery(this).html('<button class="btn btn-default pull-right playbutton">\
			<i class="glyphicon glyphicon-play"></i></button>');
	}
});

jQuery(".playbutton").click(function() {
	if (!mediaElement.paused) {
		mediaElement.pause();
	}
	mediaElement.src=jQuery(this).parent().data("listenurl");
	mediaElement.play();
	nowPlaying.html("<strong>Now playing:</strong> " + jQuery(this).parent().data("streamname"));
});

jQuery(".stopbutton").click(function() {
	if (!mediaElement.paused) {
		mediaElement.pause();
		mediaElement.src='';
		nowPlaying.html("<strong>No playback</strong>");
	}
});