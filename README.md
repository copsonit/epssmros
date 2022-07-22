# epssmros
Source code for the MROS driver used in EPSS

This was initially decompiled by one of the original MROS drivers included with Cubase, I do not remember which of them.
There are some smaller comments in Swedish but not really that important.
The things I changed was to use "EPSS" as the MROS identifier, added a desciption for the driver and then found the place where it receives the MIDI data from MROS. As EPSS is only a receiver I did not do anything for the sending back MIDI data but there might be possible to identify this as well.
I then used the trap#7 hook to send the information from MROS to EPSS, midi byte in d0.

/Copson
