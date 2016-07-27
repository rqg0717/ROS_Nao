close all;
clear all;

setenv('ROS_IP','192.168.1.3');
rosinit;

speechpub = rospublisher('/speech', rostype.std_msgs_String);
strMsg = rosmessage(speechpub);

imagesub = rossubscriber('/nao_camera/image_raw', rostype.sensor_msgs_Image);

data = imagesub.LatestMessage;
[img,alpha] = readImage(data);

nameset;
name = faceRecognition(img);

strMsg.Data = sprintf('hello %s', name);
send(speechpub, strMsg);

rosshutdown;