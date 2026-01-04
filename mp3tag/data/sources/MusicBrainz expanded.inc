##############################################################################
#
# WebSourceScript for Mp3tag, fetching Metadata from MusicBrainz.org
# Version v1.01
#
# This file will be called by a *.src file. It does not run independently.
#
##############################################################################
# This *.inc file toghether with all the linked *.src files must be placed
# in your Mp3tag sources directory, on Windows 10 found in this folder:
# %appdata%\Mp3tag\data\sources
#
# History:
# --------
#
# 2022-01-15    v1.00
# 2022-01-25    v1.01   + CHG: [Name] to MusicBrainz
#                       + FIX: Only fill metadata to matching number of tracks
#                       + CHG: Comment tag will not be written anymore
#
# 2022-04-08    v1.20   + ADD: Performing Orchestra with Begin- & End-Date
#                       + FIX: Trim "off" added for INDEX-part too
#
# Special thanks to @Florian and @ohrenkino for the support and tests
# of the preview releases
#
##############################################################################

[Name]=MusicBrainz
[BasedOn]=musicbrainz.org
[IndexUrl]=http://musicbrainz.org/ws/2/release/?fmt=json&limit=50&query=
[AlbumUrl]=http://musicbrainz.org/ws/2/release/
[WordSeparator]=%20
[IndexFormat]=%_preview%|%_url%|%Score%|%Type%|%Albumname%|%Artistname(s)%|%No of Media%|%Format%|%Total Tracks%|%Country%|%Date%|%Catalog No%|%Label/Publisher%|%ASIN%|%Barcode%|%Status%|
#[SearchBy]=will be provided by parent *.src file
[UserAgent]=1
[Encoding]=url-utf-8

[ParserScriptIndex]=...
####################################################################
#                           I  N  D  E  X
####################################################################
#
# This part is building the selection of possibly matching releases.
#
# The medata for the manually selected release will then be fetched
# in a second call from the MusicBrainz webservice server.
#
####################################################################

replace "|" "$verticalBar()"
json "ON" "current"

# Trim was introduced with Mp3tag v3.11h
# Using it before will crash this index parsing part
Trim "off"

# Check if there is any result
json_select_object "count"
json_select "count"

    ifnot "0"

    json_foreach "releases"

        # Change to releases level
        json_select_object "releases"

            # Preview (no column, only for preview)
            say "http://musicbrainz.org/release/"
            json_select "id"
                sayrest
                say "|"

            # URL (no column, only for preview)
            json_select "id"
                sayrest
                say "?inc=artists+artist-credits+isrcs+labels+release-groups+recordings+recording-level-rels+area-rels+place-rels+artist-rels"
                say "&fmt=json"
                say "|"

            # Column: Score
            json_select "score"
                sayrest
                say "|"

            # Column: Type
            # Change to release-group level
            json_select_object "release-group"
                json_foreach "release-group"
                    json_select "primary-type"
                        sayrest
                json_foreach_end
            json_unselect_object
            #json_unselect_object "release-group"
                say "|"

            # Column: Albumtitle
            json_select "title"
                sayrest
                say "|"

        json_unselect_object
        #json_unselect_object "releases"


        # Artist credit
        # Change to artist-credit level
        json_select_object "artist-credit"
            set "artist"
            json_foreach "artist-credit"
                json_select "name"
                    sayrest
                json_select "joinphrase"
                ifnot ""
                    sayrest
                endif
            json_foreach_end
            #json_foreach_end "artist-credit"

        json_unselect_object
        #json_unselect_object "artist-credit"

        # Add complete content to Column: Artistname(s)
        sayoutput "name"
        say "|"

        # Column: (# of Media)
        json_select "count"
            IfGreater 1
                set "TEMP_MultipleMedia" "y"
            else
                set "TEMP_MultipleMedia"
            endif
            sayrest
            say "|"

        # Format
        # Change to media level
        json_select_object "media"
            json_foreach "media"
                json_select "format"
                    sayrest
                json_select "track-count"
                ifnot ""
                    ifOutput "TEMP_MultipleMedia"
                        say " ("
                        sayrest
                        say ") "
                    endif
                endif
            json_foreach_end
        json_unselect_object
        #json_unselect_object "media"
        say "|"

        # Change back to releases level
        json_select_object "releases"

            # Column: Total Tracks
            json_select "track-count"
            sayrest
            say "|"

            # Column: Country
            json_select "country"
            sayrest
            say "|"

            # Column: Date
            json_select "date"
            sayrest
            say "|"

        json_unselect_object
        #json_unselect_object "releases"

        # label-info
        json_select_array "label-info" 1

            # Column: Catalog-No
            json_select "catalog-number"            
                sayrest            
                say "|"

            # Column: Label / Publisher
            json_select "label"            
            json_select "name"
                sayrest
                say "|"

        json_unselect_object
        #json_unselect_object "label-info"

        json_select_object "releases"
            # Column: Asin
            json_select "asin"
            sayrest
            say "|"

            # Column: Barcode
            json_select "barcode"
            sayrest
            say "|"

            # Column: Status
            json_select "status"
            sayrest
            say "|"

        json_unselect_object
        #json_unselect_object "releases"

        saynewline

    json_foreach_end
    #json_foreach_end "releases"

    # Delete temporary variables, don't show them
    set "TEMP_MultipleMedia"

    endif
    # endif ifnot "0"

json_unselect_object
#json_unselect_object "count"

JSON "OFF"


[ParserScriptAlbum]=...
####################################################################
#					A  L  B  U  M
####################################################################

# Necessary for special names like "M|A|R|S|S|"
replace "|" "$verticalBar()"

json "ON" "current"

# Trim was introduced with Mp3tag v3.11h
# Using it before will crash this album parsing part
Trim "off"

# In MB Picard shown as "Album"
outputto "Album"
json_select "title"
    sayrest


# In MB Picard shown as YYYY-MM-DD "Date"
outputto "Year"
json_select "date"
    saynchars 4


# In MB Picard shown as "Date"
# Strange MB Picard format, creates 2611 DDMM from date 2021-11-26 and show it together with "Year" YYYY
# In Mp3tag it is shown as DATE with 3004 and YEAR with 2021
outputto "Date"
json_select "date"
    findinline "-" 1 1
    ifnot ""
        # Search for     YYYY     MM      DD      Output it as DDMM
        RegexpReplace "^(\d{4})-(\d{2})-(\d{2})$" "$3$2"
        SayRegexp "^.*$"
    endif


# In MB Picard shown as "MusicBrainz Release Id"
outputto "MUSICBRAINZ_ALBUMID"
json_select "id"
    sayrest


# In MB Picard shown as "ASIN"
outputto "ASIN"
json_select "asin"
    sayrest


# In MB Picard shown as "Barcode"
outputto "BARCODE"
json_select "barcode"
    sayrest


# In MB Picard shown as "Release Status"
outputto "MUSICBRAINZ_ALBUMSTATUS"                   # Example: Official or Album (MB Picard shows: official or album)
json_select "status"                                 # Content remains untouched and not converted to lowercase as in MB Picard
    sayrest


# In MB Picard shown as "Release Country"
outputto "MUSICBRAINZ_ALBUMRELEASECOUNTRY"
json_select "country"
# regexpreplace "^GB$" "UK"                          # No manipulation of the source metadata, can be replaced by user if necessary
    sayrest


# In MB Picard shown as "Script"
# Change to text-representation level
json_select_object "text-representation"
    outputto "SCRIPT"
    json_select "text-representation"
        json_select "script"
            sayrest
json_unselect_object
#json_unselect_object "text-representation"


# In MB Picard shown as "MusicBrainz Release Group Id"
outputto "MUSICBRAINZ_RELEASEGROUPID"
json_select "release-group"
    json_select "id"
        sayrest


# In MB Picard shown as "Original Release Date"
outputto "ORIGYEAR"
json_select "first-release-date"
    saynchars 4
    say "|"


# In MB Picard shown as "Original Year"
outputto "originalyear"
json_select "first-release-date"
    saynchars 4
    say "|"


# In MB Picard shown as "Release Type"
outputto "MUSICBRAINZ_ALBUMTYPE"                        # Example: Album (MB Picard shows: album)
json_select "release-group"
    json_select "primary-type"                          # Remains untouched and not converted to lower case as in MB Picard
        sayrest                                         # Example: EP    (MB Picard shows: ep)


# In MB Picard shown as "Compilation (iTunes)"
# outputto "COMPILATION"
json_select "release-group"
    json_select_array "secondary-types"                 # Remains untouched and not converted to lower case as in MB Picard
    if "Compilation"                                    # if secondary-type is "Compilation", set COMPILATION to 1.
        outputto "COMPILATION"                          # MB Picard set it to 1 if AlbumArtist is "Various Artists"
        say "1"
    endif
    ifnot ""
        outputto "MUSICBRAINZ_ALBUMTYPE"
        say "/"
        sayrest
    endif                                               # Example: Album/Compilation (MB Picard shows: album/compilation)



# artist credit
# Change to artist-credit level
json_select_object "artist-credit"
    json_foreach "artist-credit"
        # In MB Picard shown as "Album Artist"
        outputto "ALBUMARTIST"
        json_select "name"
            sayrest
        json_select "joinphrase"
        ifnot ""
            sayrest
            GotoChar 1
            outputto "TEMP_MB_JOINPHRASE"
            sayrest
        else
            set "TEMP_MB_JOINPHRASE"
        endif


        # Fill artist-credit-sortname
        # In MB Picard shown as "Album Artist Sort Order"
        json_select "artist"
            json_select "sort-name"
            outputto "Albumartistsort"
                sayrest
                sayoutput "TEMP_MB_JOINPHRASE"


        # In MB Picard shown as "MusicBrainz Release Artist Id"
        json_select "artist"
            json_select "id"
            outputto "MUSICBRAINZ_ALBUMARTISTID"
                sayrest
            ifOutput "TEMP_MB_JOINPHRASE"
                say "/"
            endif

        # Immediately clear this temporary variable
        set "TEMP_MB_JOINPHRASE"

    json_foreach_end
    #json_foreach_end "artist-credit"

json_unselect_object
#json_unselect_object "artist-credit"


# Change to label-info level
json_select_object "label-info"

    # In MB Picard shown as "Catalog Number"
    outputto "CATALOGNUMBER"
    json_select_many "label-info" "catalog-number" "/"
        ifnot ""
            sayrest
        endif


    # In MB Picard shown as "Record Label"
    outputto "PUBLISHER"
    json_foreach "label-info"
        json_select "label"
            json_select "name"
            ifoutput "PUBLISHER"
                say "/"
            endif
            sayrest

            # json_select "disambiguation"  # ATTENTION: This value is NOT available in MB Picard
            # ifnot ""                      # If disambiguation is not empty
            #     say " (Disamb: "          # Add Space 'opening Parenthesis' Disamb: Space
            #     sayrest                   # Add the current disambiguation content
            #     say ")"                   # Add 'closing Parenthesis'
            # endif

    json_foreach_end
    #json_foreach_end "label-info"

json_unselect_object
#json_unselect_object "label-info"



# Release Relations details, like Engineer, Mixer, Performer (instruments)
# Change to relations level (available with +artist-rels)
json_select_object "relations"
    json_foreach "relations"
        json_select "type"

        outputto "TEMP_RELEASE_INVOLVEDPEOPLE"              # type:NAME; (engineer:Larry Alexander;mix:Steve Rinkoff;)

        if "instrument"
            json_select_object "attributes"
                json_select "attributes"
                    json_select_array "attributes" -1 ", "  # "Moog, mellotron, piano"
                        ifnot ""
                            sayrest
                            say ":"
                        endif
            json_unselect_object
            # json_unselect_object "attributes"

            json_select_object "artist"
                json_select "artist"
                json_foreach "artist"
                    json_select "name"
                        sayrest
                        # json_select "disambiguation"      # ATTENTION: This value is NOT available in MB Picard
                        #     ifnot ""                      # If disambiguation is not empty
                        #         say " ("                  # Add Space 'opening Parenthesis'
                        #         sayrest                   # Add the current disambiguation content
                        #         say ")"                   # Add 'closing Parenthesis'
                        #     endif
                json_foreach_end
                # json_foreach_end "artist"

            json_unselect_object
            # json_unselect_object "artist"
            say ";"
        endif
        # endif "instrument"


        if "vocal"
            outputto "TEMP_RELEASE_VOCAL"
            sayrest                                 # vocal
            json_select_object "attributes"
                json_select "attributes"
                json_select_array "attributes" -1
                    ifnot ""
                        say " "
                        sayrest                     # lead vocals, background vocals
                    endif
                    say ":"
            json_unselect_object
            # json_unselect_object "attributes"

            json_select "artist"
            json_foreach "artist"
                json_select "name"
                    sayrest

                    # Always add the relations-type Name
                    # json_select "disambiguation"      # ATTENTION: This value is NOT available in MB Picard
                    #     ifnot ""                      # If disambiguation is not empty
                    #         say " ("                  # Add Space 'opening Parenthesis'
                    #         sayrest                   # Add the current disambiguation content
                    #         say ")"                   # Add 'closing Parenthesis'
                    #     endif

            json_foreach_end
            # json_foreach_end "artist"
            say ";"
        endif
        # endif "vocal"

    json_foreach_end
    # json_foreach_end "relations"

json_unselect_object
#json_unselect_object "relations"



## Get the total Discnumbers BEFORE the loop starts
set "TEMP_TOTALDISCS"


# Count number of existing Medias 
json_select_object "media"

    # Start Loop to iterate through every media
    json_foreach "media"

        # In MB Picard shown as "Total Discs"
        # Write the media array size = the total Discnumbers        
        outputto "TEMP_TOTALDISCS"
            if "1"
                # Deleted, if only 1 Disc exists
                set "TEMP_DiscnumberIsOne"
            else
                # Set, if 2 or more Discs exists
                set "TEMP_DiscnumberIsOne" "YesForCheckIfNotEmpty"
            endif
            sayrest

    json_foreach_end
    #json_foreach_end "media"
    # End Loop to iterate through every media

json_unselect_object
#json_unselect_object "media"


# Track details, delivered for every track
# Change to media -> tracks level
json_select_object "media"

    # Start Loop to iterate through every media
    json_foreach "media"

        # In MB Picard shown as "Media"
        set "TEMP_MEDIATYPE"
        outputto "TEMP_MEDIATYPE"
        json_select "format"
            sayrest


        # In MB Picard shown as "Disc Subtitle"
        set "TEMP_TrackDiscTitle"
        outputto "TEMP_TrackDiscTitle"
        json_select "title"
            sayrest


        # In MB Picard shown as "Total Tracks"
        set "totaltracks"
        outputto "totaltracks"
        json_select "track-count"
            sayrest


        set "TEMP_DISCNUMBER"
        outputto "TEMP_DISCNUMBER"
        json_select "position"
            sayrest


        # Start Loop to iterate through every track
        # -----------------------------------------
        json_foreach "tracks"

            # Construct the detail row for every track, with at least
            # track number, optional /Total Tracks, track titel, track length

            # In MB Picard shown as (Track-) "Track Number"
            outputto "Track"
            json_select "number"
                sayrest
            ifnot "totaltracks"
                say "/"
                sayoutput "totaltracks"
            endif
            say "|"


            # In MB Picard shown as (Track-) "Title"
            outputto "Title"
            json_select "title"
                sayrest
                say "|"


            # Tracks (extremely important to fill the correct number of tracks with the available metadata)
            outputto "tracks"
                say "|"


            # Write current Discnumber per Track
            # In MB Picard shown as (Track-) "Disc Number"
            IfOutput "TEMP_DiscnumberIsOne"                         # Only Discnumbers greater then 1 will be written
                outputto "Discnumber"                               # Prevents "useless" Discnumber 1/1
                sayoutput "TEMP_DISCNUMBER"
                ifnot "TEMP_TOTALDISCS"
                    say "/"
                    sayoutput "TEMP_TOTALDISCS"
                endif
                say "|"
            endif


            # In MB Picard shown as "MusicBrainz Track Id"
            outputto "MUSICBRAINZ_RELEASETRACKID"
            json_select "id"
               sayrest
               say "|"


            # In MB Picard shown as "Disc Subtitle"                 # id3Tag TSST is officially only available in ID3v2.4
            outputto "SetSubtitle"                                  # MB Picard - but not Mp3tag - write it also in ID3v2.3 for "compatibility reasons"
            sayoutput "TEMP_TrackDiscTitle"                         # https://community.mp3tag.de/t/add-field-mapping-for-musicbrainz-picard/44062/8
                say "|"                                             # You have to set a MB Picard-Tagger script for full compatibility


            # In MB Picard shown as "Media"
            outputto "MediaType"
            sayoutput "TEMP_MEDIATYPE"
                say "|"


            # Artist-Credits from Track-Level, not Release-Level for compatibility to MB Picard
            json_select "artist-credit"
                json_foreach "artist-credit"
                    # In MB Picard shown as (Album Main-) "Artist"
                    outputto "Artist"
                    json_select "name"
                        sayrest

                    json_select "joinphrase"
                    ifnot ""
                        sayrest
                    endif
                json_foreach_end
                # json_foreach_end "artist-credit"
                say "|"


            json_select "artist-credit"
                json_foreach "artist-credit"
                    # In MB Picard shown as (Track-) "Artist Sort Order"
                    json_select_object "artist"
                        outputto "Artistsort"
                        json_select "sort-name"
                            sayrest
                    json_unselect_object # "artist"

                    json_select "joinphrase"
                    ifnot ""
                        sayrest
                    endif
                json_foreach_end
                # json_foreach_end "artist-credit"
                say "|"


            json_select "artist-credit"
                json_foreach "artist-credit"
                    # In MB Picard shown as (Track-) "Artists"
                        outputto "ARTISTS"
                        json_select "name"
                            sayrest

                    json_select "joinphrase"
                    ifnot ""
                        say "/"
                    endif
                json_foreach_end
                # json_foreach_end "artist-credit"
                say "|"


            json_select "artist-credit"
                json_foreach "artist-credit"
                    # In MB Picard shown as "MusicBrainz Artist Id"
                    json_select_object "artist"
                        outputto "MUSICBRAINZ_ARTISTID"
                        json_select "id"
                            sayrest
                    json_unselect_object # "artist"

                    json_select "joinphrase"
                        ifnot ""
                            say "/"
                        endif
                    # json_unselect_object
                json_foreach_end
                # json_foreach_end "artist-credit"
                say "|"


            # Show Track-Length, will not be saved anywhere
            outputto "_LENGTH"
                json_select "length"
                sayrest
                say ", "


            # Change to media -> tracks -> recording level
            outputto "_LENGTH"
            json_select "recording"
                json_select "length"
                sayrest
                say "|"


            # In MB Picard shown as "MusicBrainz Recording Id"
            outputto "MUSICBRAINZ_TRACKID"
                json_select "id"
                    sayrest
                    say "|"


            # Special tag ISRC (International Standard Recording Code)
            json_select_object "recording"
                json_select "recording"
                    # https://en.wikipedia.org/wiki/International_Standard_Recording_Code
                    # Format   CC-RGC-YY-DESCO (CountryCode, RegistrantCode, YearOfReference, DesignatinCode)
                    # Example: CA-CWV-21-15971
                    # In MB Picard shown as "ISRC"
                    outputto "ISRC"
                    json_select_array "isrcs" -1 "/"
                            # Unformatted version:
                            sayrest                          # Remains untouched and unformated
                            # Formatted version:
                            #RegexpReplace "(([A-Z]{2})?(\w{3}?)(\d{2})?(\d{5}))" "$2-$3-$4-$5"
                            #SayRegexp "^.*$"                # Prettyfied format
                            say "|"

                    json_select_object "relations"
                        json_foreach "relations"
                            json_select "type"

                            if "performing orchestra"
                                set "TEMP_Recording_PerfOrchestra_BeginDate"
                                outputto "TEMP_Recording_PerfOrchestra_BeginDate"                            
                                json_select "begin"
                                    sayrest
                                
                                set "TEMP_Recording_PerfOrchestra_EndDate"
                                outputto "TEMP_Recording_PerfOrchestra_EndDate"                            
                                json_select "end"
                                    sayrest
                            
                                set "TEMP_Recording_PerfOrchestra"
                                outputto "TEMP_Recording_PerfOrchestra"
                            
                                json_select "artist"
                                json_foreach "artist"
                                    json_select "name"
                                        sayrest                                         
                                json_foreach_end
                                # json_foreach_end "artist"
                            
                            endif
                            # endif "performing orchestra"

                        json_foreach_end
                        # json_foreach_end "relations"

                    json_unselect_object
                    #json_unselect_object "relations"

            json_unselect_object
            # json_unselect_object "recording"

            # Build the INVOLVEDPEOPLE tag with all the various TEMP_ content
            outputto "INVOLVEDPEOPLE"

            # From the release-level, only the Instruments and Vocals
            # otherwise we had to copy & paste the entire relations-part from track-level to release-level
            sayoutput "TEMP_RELEASE_INVOLVEDPEOPLE"
            sayoutput "TEMP_RELEASE_VOCAL"
            say "|"
            
            outputto "PERFORMING_ORCHESTRA"
            sayoutput "TEMP_Recording_PerfOrchestra"
            say "|"
            
            outputto "PERFORMING_ORCHESTRA_BEGINDATE"
            sayoutput "TEMP_Recording_PerfOrchestra_BeginDate"
            say "|"
            
            outputto "PERFORMING_ORCHESTRA_ENDDATE"
            sayoutput "TEMP_Recording_PerfOrchestra_EndDate"
            say "|"
            
        json_foreach_end
        # json_foreach_end "tracks"
        # ---------------------------------------
        # End Loop to iterate through every track

    json_foreach_end
    #json_foreach_end "media"
    # End Loop to iterate through every media


    # Note:
    # Write last number of discs (= Total number of discs)
    # In MB Picard shown as "Total Discs"
    #   This is not necessary, because MB Picard reads the "Total Discs" from DISCNUMBER in Format 3/6
    #   If someone would like to see the "Total Discs" outside MB Picard, the next 3 lines
    #   must be activated by deleting the leading # character
    # outputto "totaldiscs"
    # sayoutput "TEMP_TOTALDISCS"
    # say "|"

    # This is also true for the MB Picard "Total Tracks", read from TRACK in Format 10/30

json_unselect_object
#json_unselect_object "media"


# Cover Art, if available at the CoverArtArchive or at Amazon
# Change to cover-art-archive level
json_select_object "cover-art-archive"
    json_select "count"
        # If "NEVER-EVER"     # Debug only, much faster without CoverArt Download
        IfNot "0"
            # Cover via CoverArtArchive (CAA)
            outputto "coverurl"
            say "http://coverartarchive.org/release/"
            sayoutput "MUSICBRAINZ_ALBUMID"
            # Since Mp3tag v3.11h we can configure one of the 4 available "MusicBrainz Cover Size"
            # in Tools -> Options -> Tag Sources:
            # 250 Pixels, 500 Pixels, 1200 Pixels or the Original size
            # An Original size 7000 Pixel Cover with 50MB needs up to 60 seconds to download
            say "/front"

        else
           #Cover via ASIN
           #If "NEVER-EVER"     # Debug only, much faster without CoverArt Download
           ifOutput "ASIN"
               outputto "coverurl"
               say "http://images.amazon.com/images/P/"
               sayoutput "ASIN"
               say ".01.LZZZZZZZ.jpg"
           endif
        endif
        # endif "ifNot 0"
json_unselect_object # "cover-art-archive"


# Not shown/set by default in MB Picard, just to identify the data source
# outputto "Comment"
# say "Tagged with one of the Mp3tag WS Scripts MusicBrainz expanded v1.00"

JSON "OFF"

# Delete temporary variables, don't show them
set "TEMP_DISCNUMBER"
set "TEMP_DiscnumberIsOne"
set "TEMP_DUMMY"
set "TEMP_FirstPlaceLoopRun"
set "TEMP_FirstStartDateRun"
set "TEMP_FirstEndDateRun"
set "TEMP_MB_JOINPHRASE"
set "TEMP_MEDIATYPE"
set "TEMP_MultipleMedia"
set "TEMP_RELEASE_INVOLVEDPEOPLE"       # Do not delete it per Track, it's the same for entire release
set "TEMP_RELEASE_VOCAL"                # Do not delete it per Track, it's the same for entire release
set "TEMP_TOTALDISCS"
set "TEMP_TrackDiscTitle"
set "TEMP_Recording_PerfOrchestra"
set "TEMP_Recording_PerfOrchestra_BeginDate"
set "TEMP_Recording_PerfOrchestra_EndDate"

#######################################################################
#
# If you want to skip a tag, you can just delete the # sign
# in front of the following tags:
#
#######################################################################

#set "Title"
#set "Artist"
#set "Album"
#set "Track"
#Length can't be set or unset
#set "Year"
#set "Date"
#set "ALBUMARTIST"
#set "Albumartistsort"
#set "Artistsort"
#set "ARTISTS"
#set "ASIN"
#set "BARCODE"
#set "CATALOGNUMBER"
#set "Comment"
#set "COMPILATION"
#set "Discnumber"
#set "ISRC"
#set "MEDIATYPE"
#set "MUSICBRAINZ_ARTISTID"
#set "MUSICBRAINZ_TRACKID"
#set "MUSICBRAINZ_ALBUMARTISTID"
#set "MUSICBRAINZ_RELEASEGROUPID"
#set "MUSICBRAINZ_ALBUMID"
#set "MUSICBRAINZ_RELEASETRACKID"
#set "ORIGYEAR"
#set "originalyear"
#set "PERFORMING_ORCHESTRA"
#set "PERFORMING_ORCHESTRA_BEGINDATE"
#set "PERFORMING_ORCHESTRA_ENDDATE"
            

# MusicBrainz Picard shows the content of the INVOLVEDPEOPLE tag in at least
# 3 categories: Engineer, Mixer, Performers (including the type of instrument)
#set "INVOLVEDPEOPLE"

#set "PUBLISHER"
#set "MUSICBRAINZ_ALBUMRELEASECOUNTRY"
#set "MUSICBRAINZ_ALBUMSTATUS"
#set "MUSICBRAINZ_ALBUMTYPE"
#set "SCRIPT"

# You need to set a MB Picard Tagger script for compatibility
#   $set(SetSubtitle,%discsubtitle%)
#   $unset(discsubtitle)
#
#set "SetSubtitle"

# MusicBrainz Picard reads the "Total Discs" from "DISCNUMBER" in format "1/3"
# if you want to see TOTALDISCS tag with content outside MB Picard
# set a # in front of the following line
#
set "totaldiscs"

# MusicBrainz Picard reads the "Total Tracks" from "TRACK" in format "10/30"
# if you want to see TOTALTRACKS tag with content outside MB Picard
# set a # in front of the following line
#
set "totaltracks"

# If you don't want a cover at all, you can configure it in the Mp3tag-GUI
# The "Util-Button" in the lower left corner of the websource result window
# let you choose, if and where to save a cover.
# You can also prevent a cover will be downloaded, if you remove
# the # in the following line
# set "coverurl"