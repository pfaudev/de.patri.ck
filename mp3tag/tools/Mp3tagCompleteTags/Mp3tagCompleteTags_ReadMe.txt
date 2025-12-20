
*** Mp3tagCompleteTags.exe v2.3 ***
        created by dano
          
          
This tool that lets you export all tag fields of the currently selected files


 ..::Note::..
--------------
By default it only Works if your Mp3tag settings are in %appdata%\Mp3tag
i.e.
c:\Users\{user}\AppData\Roaming\Mp3tag\

See Settings.ini help below for portable Mp3tag support.


 ..::Installation::..
----------------------
  1. Copy Mp3tagCompleteTags.exe to a folder of your choice.
  2. Run it once!
  3. In Mp3tag go to "Tools > Options > Tools" and add Mp3tagCompleteTags.exe as a tool.
     As parameter add "%_workingpath%" (with quotes)
      "[ ] for all selected files" must be unchecked!
     (See screenshot Mp3tag_Tools_example.png)
  4. (Optional but recommended) Go to "Tools > Options > Messages"
     and disable "[ ] after change"

 ..::Usage::..
---------------
for Mp3tag v2.47 and newer

  1. Select all the files you want to export in Mp3tag
  2. Right click on a file and select "Tools > Mp3tagCompleteTags"

for Mp3tag v2.46 and older

  1. Select all the files you want to export in Mp3tag
  2. Execute the action "Export#Generate"
  3. Right click on a file and select "Tools > Mp3tagCompleteTags"


 ..::Settings.ini::..
 ---------------------
1) PortablePath
You can add the path of a portable Mp3tag installion here.
Settings and config files will be read/written there.
It must end with a backslash.


 ..::Credits::..
-----------------
Thanks to DetlevD

