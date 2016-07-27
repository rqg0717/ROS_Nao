function [name, personLabel] = faceRecognition(videoFrame)
% Create a cascade detector object.
load faceClassifier;
faceDetector = vision.CascadeObjectDetector();
bbox2            = step(faceDetector, videoFrame);
bbox = bbox2(1,:);
%continuous checking and outputing image if a human face is not found in
%the videoframe input.
while(size(bbox,1)<1)
    videoFrame= step(videoFileReader);
    bbox= step(faceDetector, videoFrame);
end

% Convert the first box to a polygon.
% This is needed to be able to visualize the rotation of the object.
x = bbox(1, 1); y = bbox(1, 2); w = bbox(1, 3); h = bbox(1, 4);
bboxPolygon = [x, y, x+w, y, x+w, y+h, x, y+h];

% Draw the returned bounding box around the detected face.
videoFrame = insertShape(videoFrame, 'Polygon', bboxPolygon);

figure(1); imshow(videoFrame); title('Detected face');

% Detect feature points in the face region.
points = detectMinEigenFeatures(rgb2gray(videoFrame), 'ROI', bbox);
size(points)
% Display the detected points.
figure('name','detected'), imshow(videoFrame), hold on, title('Detected features');
plot(points);

% Create a point tracker and enable the bidirectional error constraint to
% make it more robust in the presence of noise and clutter.
pointTracker = vision.PointTracker('MaxBidirectionalError', 2);

% Initialize the tracker with the initial point locations and the initial
% video frame.
points = points.Location;
initialize(pointTracker, points, videoFrame);

%set(0, 'ShowHiddenHandles', 'on') % Revert this back to off after you get the handle

videoPlayer  = vision.VideoPlayer('Position',...
    [100 100 [size(videoFrame, 2), size(videoFrame, 1)]+30]);

% Make a copy of the points to be used for computing the geometric
% transformation between the points in the previous and the current frames
oldPoints = points;

% Track the points. Note that some points may be lost.
[points, isFound] = step(pointTracker, videoFrame);
visiblePoints = points(isFound, :);
oldInliers = oldPoints(isFound, :);
%
if size(visiblePoints, 1) >= 2 % need at least 2 points
    matchPic = imcropPolygon(bboxPolygon,videoFrame);
    matchPic = cutPic(matchPic);

    queryFeatures = extractHOGFeatures(matchPic);
    personLabel = predict(faceClassifier,queryFeatures);
    curpath = pwd;
    filestr=strcat(curpath, '\Database\', personLabel, '\1.pgm');
    imshow(imread(char(filestr), 'pgm'));
    
    name = mapObj(char(personLabel));
    
    {personLabel name}
end

% Clean up
%release(videoFileReader);
release(videoPlayer);
release(pointTracker);
end