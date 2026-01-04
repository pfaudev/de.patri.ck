# ##################################################################
#                       WTF PUBLIC LICENSE
#                   Public Version 15, Jul 2021
#
# Copyright (C) 2020-2021 Bugzero <bugzero71@gmail.com>
# I would like to thank stevehero for his scripts. I've learned a lot.
#
# Everyone is permitted to copy and distribute verbatim or modified
# copies of this license document, and changing it is allowed as long
# as the name is changed.
#
#                       WTF PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You can do WTF you imagine with this document.
# ##################################################################
# Help on Web Sources Framework: https://help.mp3tag.de/main_online.html
# ##################################################################

[Name]=Tunebat (HTML parser) [0.99a by Bugzero]
[BasedOn]=https://tunebat.com
[IndexUrl]=https://tunebat.com/Search?q=%s
[AlbumUrl]=
[WordSeperator]=+
[IndexFormat]=%_url%|%artist%|%title%|%key%|%bpm%|%camelot%|%spotify_url%
[Encoding]=url-utf-8

[ParserScriptIndex]=...
# ###################################################################
#					I  N  D  E  X
# ###################################################################
# debug "on" "Tunebat-debug_INDEX.log"
# debugwriteinput "debug_tunebat_input.html"

findline "<div class=\"_1G5AR\">"
regexpreplace ".*?<div class=\"_1G5AR\">(.*)</main>" "$1"
regexpreplace "<footer class.*" ""
regexpreplace "<div class=\"ant-col[^>]*?><a href=\"([^\"]+?)\">" "<<start_track>><url>https://tunebat.com$1</url>"
regexpreplace "<div class=[^>]*?><p class=[^>]*?>([^<]*?)<\/p><p class=[^>]*?>([^<]*?)<\/p><\/div>" "<$2>$1</$2>"
regexpreplace "<div class=\"ant-typ[^>]*?>([^<]*?)<\/div><div class=\"ant-typ[^>]*?>([^<]*?)<\/div>" "<artist>$1</artist><track>$2</track>"
regexpreplace "<div class=\"ant-col[^>]*?>" ""
regexpreplace "<span [^>]*?><\/span>" ""
regexpreplace "<div [^>]*?><\/div>" ""
regexpreplace "<button .*?<\/button>" ""
regexpreplace "<i [^>]*?><\/i>" ""
regexpreplace "<div [^>]*?>" ""
replace "</span>" ""
replace "</div>" ""
regexpreplace "<a href=\"([^\"]*?)\"[^>]*?><\/a>" "<spotify>$1</spotify><<end_track>>"
replace "</a>" ""

do
    # find node start
    findinline "<<start_track>>"

	# URL
	findinline "<url>"
	sayuntil "</url>"
	say "|"

	# COVERURL
	#findinline "<cover>"
	#sayuntil "</cover>"
	#say "|"

	# Artist
	findinline "<artist>"
	sayuntil "</artist>"
	say "|"

	# Title
	findinline "<track>"
	sayuntil "</track>"
	say "|"

	# Key
	findinline "<Key>"
	sayuntil "</Key>"
	say "|"

	# BPM
	findinline "<BPM>"
	sayuntil "</BPM>"
	say "|"

	# Camelot
	findinline "<Camelot>"
	sayuntil "</Camelot>"
	say "|"
	
	# Spotify Url
	findinline "<spotify>"
	sayuntil "</spotify>"
	
	saynewline
	
	findinline "<<end_track>>"
	
while "<<start_track>>" 50
	

[ParserScriptAlbum]=...
# ###################################################################
#					A  L  B  U  M
# ###################################################################
# debug "on" "Tunebat-debug_AlbumParser.log"
# debugwriteinput "debug_tunebat_input.html"

findline "<body>"
joinuntil "</body>"
unspace

replace "&quot;" "\""
replace "&#x27;" "'"
replace "&#39;" ","
replace "&amp;" "&"

replace "\\u0022" "\""
replace "\\u0027" "'"

regexpreplace "<div[^>]*?>" ""
replace "<!-- -->" ""                      # remove unusable comments

# Artist and track
regexpreplace "<h3[^>]+?>([^:]+?)<\/h3><h1[^>]+?>([^<]+?)<\/h1>" "<artist>$1</artist><track>$2</track>"

# BPM, Camelot, Key,
regexpreplace "<h\d[^>]*?>([^<]+?)<\/h\d><span[^>]+?>([^<]+?)<\/span>" "<$2>$1</$2>"

# Date, Explicit, Label
regexpreplace "<span[^>]+?>([^:]+?):\s*<span[^>]+?>\s*([^<]+?)\s*<\/span><\/span>" "<$1>$2</$1>"
regexpreplace "<span [^>]+?>([^:]+?):\s*<a\s*[^>]+?>\s*([^<]+?)\s*<\/a><\/span>" "<$1>$2</$1>"

regexpreplace "<(?:button|defs|input|li|path|polygon|section|style|svg|table|ul)\s*[^>]*?>" ""
regexpreplace "<\/(?:div|button|defs|input|li|path|polygon|section|style|svg|table|ul|t\w?|h\d?)>" ""
regexpreplace "<[gi]\s+[^>]*?>" ""
regexpreplace "<\/[gi]>" ""

# Popularity, danceability....
regexpreplace "<span[^>]+?>\s*([^<>]+?)\s*<\/span><span[^>]+?>([^<>]+?)<\/span>" "<$2>$1</$2>"

regexpreplace "<\s*p[^>]*?>[^<]*?<\s*\/\s*p\s*>" ""

# JSON
regexpreplace "<script>.*serverModelJSONstring\":\"" "<json>"
regexpreplace ",\"r\":\[{.*<\/body>" "}}</json>"
regexpreplace "<\/loudness>.*<json>" "</loudness><json>"

# Spotify
regexpreplace "<a\s*href=\"([^\"]+?)\"[^>]+?><\/a>" "<spotify_url>$1</spotify_url>"

regexpreplace "<span\s*[^>]*?>" ""
regexpreplace "<a\s+[^>]*?>" ""
replace "</span>" ""
replace "</a>" ""
regexpreplace "(?i).*(<artist>)" "$1"

#regexpreplace "<Label>\s*?<!-- -->(.*?)</Label>" "<publisher>$1</publisher>"
regexpreplace "<Label>\s*?(.*?)</Label>" "<publisher>$1</publisher>"

# DATE
regexpreplace "<Release\s*Date>(\w+) (\d), (\d\d\d\d)</Release\s*Date>" "<date>$3-$1-0$2</date>"
regexpreplace "<Release\s*Date>(\w+) (\d\d), (\d\d\d\d)</Release\s*Date>" "<date>$3-$1-$2</date>"
replace "-Jan-" "-01-"
replace "-January-" "-01-"
replace "-Feb-" "-02-"
replace "-February-" "-02-"
replace "-Mar-" "-03-"
replace "-March-" "-03-"
replace "-Apr-" "-04-"
replace "-April-" "-04-"
replace "-May-" "-05-"
replace "-Jun-" "-06-"
replace "-June-" "-06-"
replace "-Jul-" "-07-"
replace "-July-" "-07-"
replace "-Aug-" "-08-"
replace "-August-" "-08-"
replace "-Sep-" "-09-"
replace "-September-" "-09-"
replace "-Oct-" "-10-"
replace "-October-" "-10-"
replace "-Nov-" "-11-"
replace "-November-" "-11-"
replace "-Dec-" "-12-"
replace "-December-" "-12-"

#
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
#
# From HTML source

# ARTIST
outputto "ARTIST"
findinline "<artist>"
sayuntil "</artist>"

# TITLE
outputto "TITLE"
findinline "<track>"
sayuntil "</track>"

# Spotify URL
outputto "SPOTIFY_URL"
findinline "<spotify_url>"
sayuntil "</spotify_url>"

# INITIALKEY
outputto "INITIALKEY"
findinline "<key>"
sayuntil "</key>"

# CAMELOT
outputto "CAMELOT"
findinline "<camelot>"
sayuntil "</camelot>"

# BPM
outputto "BPM"
findinline "<BPM>"
sayuntil "</BPM>"

# _TIME_CHECK (shows track length when only single track available, convenient to check time comparison)
outputto "_TIME_CHECK"
findinline "<duration>"
sayuntil "</duration>"

# YEAR
outputto "YEAR"
findinline "<date>"
sayuntil "</date>"

# Explicit
outputto "EXPLICIT"
findinline "<Explicit>"
sayuntil "</Explicit>"

# PUBLISHER/LABEL
outputto "PUBLISHER"
findinline "<publisher>"
sayuntil "</publisher>"

# POPULARITY
outputto "POPULARITY"
findinline "<popularity>"
sayuntil "</popularity>"

# ENERGY
outputto "ENERGY"
findinline "<energy>"
sayuntil "</energy>"

# DANCEABILITY
outputto "DANCEABILITY"
findinline "<danceability>"
sayuntil "</danceability>"

# HAPPINESS
outputto "HAPPINESS"
findinline "<happiness>"
sayuntil "</happiness>"

# ACOUSTICNESS
outputto "ACOUSTICNESS"
findinline "<acousticness>"
sayuntil "</acousticness>"

# INSTRUMENTALNESS
outputto "INSTRUMENTALNESS"
findinline "<instrumentalness>"
sayuntil "</instrumentalness>"

# LIVENESS
outputto "LIVENESS"
findinline "<liveness>"
sayuntil "</liveness>"

# SPEECHINESS
outputto "SPEECHINESS"
findinline "<speechiness>"
sayuntil "</speechiness>"

# LOUDNESS
outputto "LOUDNESS"
findinline "<loudness>"
sayuntil "</loudness>"

#
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
#
# Forced from JSON
replace "</json>" ""
regexpreplace ".*<json>" ""

# COVERURL
outputto "COVERURL"
json "ON" "current"
json_select_object "track"
json_select_array "im" 1
sayrest

#
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
#
# ALBUM
outputto "ALBUM"
sayoutput "TITLE"

# ALBUMARTIST
outputto "ALBUMARTIST"
sayoutput "ARTIST"

# ALBUM ARTIST
outputto "ALBUM ARTIST"
sayoutput "ARTIST"

# DATE
outputto "DATE"
sayoutput "YEAR"

# DISCNUMBER
outputto "DISCNUMBER"
say "1"

# RELEASETIME
outputto "RELEASETIME"
sayoutput "YEAR"

# TRACK
outputto "TRACK"
say "01/01"

#
##::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::#
#
# set "_TIME_CHECK"
# set "ALBUM"
# set "ALBUMARTIST"           # ITUNES USES
# set "ALBUM ARTIST"          # EXTRA FIELD, ALBUM ARTIST USED IN VLC AND OTHERS
# set "ARTIST"
# set "BPM"
# set "COVERURL"
set "DATE"
# set "DISCNUMBER"            # EXTRA FIELD
# set "INITIALKEY"
# set "CAMELOT"
# set "PUBLISHER"             # RECORD LABEL
# set "RELEASETIME"
# set "TITLE"
# set "TRACK"                 # NO'S OF TRACKS E.G. 01/06 (if set goes back to default 1, 2, 3... etc)
# set "YEAR"

# Extra data
set "SPOTIFY_URL"
set "EXPLICIT"
set "POPULARITY"
set "ENERGY"
set "DANCEABILITY"
set "HAPPINESS"
set "ACOUSTICNESS"
set "INSTRUMENTALNESS"
set "LIVENESS"
set "SPEECHINESS"
set "LOUDNESS"

#
# ########################################################################################## #
#
#       :JBB   .        .                               .                         
#    rMBBBB1   BBBMBBQQBQ                               B                      :  
#   .BBBBB         BQ                                  .B                     .B  
#   PZQBB          Bg  B.      B: MPYBBBP.     SBBBd   .B.1BBBP      bBBBISB  BBBB
#    iEBBr         BR  Br      BY BBQi.:PB2  :B2.  YBJ  BBd:.:dBJ  vBd:.:EBB. .B. 
#  PBBBBBB7        BR  B.      Bi B      .B  Bg .:..XB  Q:     :B  B:      B.  B  
# BQBBBBBQB        BQ  B7      Br B.      Bi BMJPbb2s2  B       B  B       B.  B  
# gBBBBBBBB        BB  uB7   .vBi B.      B7 PB     g: .B1:   .BB  BB.   :jB.  BIB
#   QBBBBK         g5    EQgREbQ  B       B.  .EMEMg7   BgbRMQQ:    :gQgRPMB   BQ 
#
# ########################################################################################## #
#

