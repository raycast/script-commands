# Photo Mechanic

Scripts for [Camera Bits Photo Mechanic](https://home.camerabits.com), a fast photo culling and metadata tool popular in photojournalism workflows.

## Commands

### Send Lightroom Photo to Photo Mechanic

Reveals the currently active photo in Adobe Lightroom Classic inside Photo Mechanic, replicating the behavior of dragging the file onto Photo Mechanic's icon. The containing folder opens as a contact sheet with the specific image selected.

**Use case:** Photojournalists and editorial shooters who cull and caption in Photo Mechanic but edit in Lightroom Classic — or vice versa — and want a one-keystroke handoff between the two apps.

#### Requirements

- **Adobe Lightroom Classic** (cloud Lightroom is not supported — it has no AppleScript interface)
- **Photo Mechanic Plus**, **Photo Mechanic 6**, or legacy Photo Mechanic

#### Permissions

On first run, macOS will prompt Raycast to control three apps:

- Adobe Lightroom Classic
- System Events (to send the Show in Finder keystroke)
- Finder (to read the revealed file path)

Approve all three. They are a one-time grant and can be reviewed under **System Settings → Privacy & Security → Automation**.

#### Notes

- Works from Lightroom's Library and Develop modules
- If multiple photos are selected, the active (most-recently-clicked) photo is sent — this matches Lightroom's own Show in Finder behavior
- Missing originals and offline network drives produce a notification with the path rather than a silent failure
