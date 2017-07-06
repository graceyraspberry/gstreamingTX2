# gstreamingTX2
Streaming (usb/native camera) on TX2

First, get the IP address of your host and clone the repo. Change directory into the folder.

    ifconfig
    (to get the IP address of the machine that you are going to be streaming from.)

ssh into the Jetson and git clone the repo. 
    `vi homeclient.sh`

Use the IP address you got earlier to replace the client IP. Run lsusb to find the ID of the USB camera that you are streaming with. Change the 'sensor_id' to the id of the usb camera.

`CLIENT_IP=[IP ADDRESS HERE] gst-launch-1.0 nvcamerasrc sensor_id=0 fpsRange="30 30" intent=3 ! nvvidconv flip-method=6
! 'video/x-raw(memory:NVMM)' !
omxh264enc control-rate=2 bitrate=4000000 ! 'video/x-h264, stream-format=(string)byte-stream' !
h264parse ! rtph264pay mtu=1400 ! udpsink host=$CLIENT_IP port=5000 sync=false async=false`

On the Jetson, run
  `sudo sh homeserver.sh`
  
and on your machine, run
  `sudo sh homeclient.sh`
  
  HAPPY STREAMING! :)
 
