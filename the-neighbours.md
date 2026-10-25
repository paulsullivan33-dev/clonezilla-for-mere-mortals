# The Neighbours

Clonezilla sits among tools that overlap it
on one side or another. What each trades
away, briefly.

## `dd` and ddrescue — the floor underneath

**dd** copies bytes from anywhere to
anywhere, understanding nothing. Clonezilla
itself falls back to it for filesystems
partclone cannot read (chapter 1), because
blunt has one great virtue: it works on
everything, including filesystems nobody has
written a reader for. The costs are the ones
this guide has been measuring in reverse: dd
copies free blocks too (huge images, slow),
and it has no opinion about whether the copy
is sane.

**ddrescue** is dd rebuilt for failing
hardware: easy blocks first, a persistent
map file, patient retries on the bad spots.
It is not an imaging *system* — no partition
bookkeeping, no compression shelf, no
restore wizard — and it is the correct first
tool when the disk itself is the emergency
(chapter 11's recipe). Partclone even speaks
its language, accepting ddrescue domain logs
(transcript t03).

## Rescuezilla and Foxclone — the same engine, a face

**Rescuezilla** is a graphical front end that
is compatible with Clonezilla images: point-
and-click saving and restoring, in a friendlier
window, built on the same partclone engine.
If the dialogs of chapters 5 and 6 are the
obstacle, this is the honest alternative —
the images interoperate. **Foxclone** covers
similar ground from the same family tree.
What you trade: the scriptable engine room
(`ocs-sr`, chapter 2) and the live system's
exact behaviour, for the comfort of the
window. The images are the portable part;
the interface is a matter of taste.

## File-level backup tools — the other promise

Timeshift, rsync-based tools, and their kin
(chapter 1's other half) keep your *files*
safe and restorable one at a time, on a
schedule, while the system runs. They cannot
return a machine to bootable life from bare
metal without help. Neither tool is the
other's rival; they answer different phone
calls. Most careful setups run both: files
continuously, images at turning points.

## Clonezilla SE and FOG — the many-machine editions

**Clonezilla SE** (server edition, on the
DRBL server the same project maintains)
deploys one image to many machines across a
network at once — the classroom and office
tool, and the home of the multicast options
you will see in `ocs-sr`'s usage. **FOG** is
an independent project doing network imaging
as a managed service, with inventories and
scheduling. Both are real infrastructure —
a server, a network that cooperates — and
both are outside this guide's one-machine
scope for the same reason: the reader with
two machines and a USB stick is not their
audience, much as the reader with forty is
not live's.

## Virtual-disk tools — the image that stays a file

Disk2vhd, `qemu-img`, and the virtualisation
world keep a disk as a file a hypervisor can
boot. A Clonezilla image is an archive to be
written back onto hardware; a virtual disk is
a disk that lives as a file permanently.
Converting between the two worlds exists
(the `ocs-img-2-vdk` tool rides along in the
live system's family) but each format is
happiest at home.
