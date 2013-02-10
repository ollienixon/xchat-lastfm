## 	Use Modules 			##
use XML::Simple;
use LWP::Simple;

## 	last.fm home address 	##
## 	change to your own 		##
$home = "http://www.last.fm/user/OllieZenum";

## 	last.fm feed rss 		##
## 	change to your own 		##
$url = "http://ws.audioscrobbler.com/1.0/user/OllieZenum/recenttracks.rss";

##	Registering The Script 	##
##	and Commands 			##
Xchat::register("LastFM", "0.1", "A Script to display the latest song listed on your last.fm");
Xchat::hook_command("np", np);

## 	Text to print when		## 
##	the script is loaded 	## 
sub lastfm_load { 
	Xchat::command("ECHO ---");
	Xchat::command("ECHO LastFM Now Playing Script by Ollie Nixon");
	Xchat::command("ECHO ---");
	return Xchat::EAT_NONE;
}
lastfm_load();


## 	Main function 			##
sub np {
	my $xml = new XML::Simple;
	my $content = get($url);
	if(!$content) {
		Xchat::command("ECHO Could not retrieve $url");
		return Xchat::EAT_NONE;
	} else {
		my $rss = $xml->XMLin($content);
		for ($i = 0; $i < 1; $i ++) {
			my $title = $rss->{channel}->{item}[$i]->{title};
			my $date = $rss->{channel}->{item}[$i]->{pubDate};
			$date =~ s/\+0000//;
			Xchat::command("ME is listening to: $title");
		}
	}
	return Xchat::EAT_NONE;
}