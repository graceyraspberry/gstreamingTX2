CLIENT_IP=10.0.0.1 #replace with client IP
gst-launch-1.0 nvcamerasrc sensor_id=0 #0 is native camera on Jetson, replace w/ usb cam ID
fpsRange="30 30" intent=3 ! nvvidconv flip-method=6 \
! 'video/x-raw(memory:NVMM)' ! \
omxh264enc control-rate=2 bitrate=4000000 ! 'video/x-h264, stream-format=(string)byte-stream' ! \
h264parse ! rtph264pay mtu=1400 ! udpsink host=$CLIENT_IP port=5000 sync=false async=false
