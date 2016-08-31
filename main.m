close all;
clear all;

setenv('ROS_IP','192.168.1.3');
rosinit;

speechpub = rospublisher('/speech', rostype.std_msgs_String);
strMsg = rosmessage(speechpub);

imagesub = rossubscriber('/nao_camera/image_raw', rostype.sensor_msgs_Image);

data = imagesub.LatestMessage;

stat=-1;

while(stat ~=0)
    [img,alpha] = readImage(data);
    [name, tst, stat] = faceRecognition(img);
    if (stat ==0)
        break; 
    end
end

nameset;

strMsg.Data = sprintf('hello %s', name);
send(speechpub, strMsg);

rosshutdown;
