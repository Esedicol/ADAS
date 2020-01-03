close all

clc

vid = VideoReader('EBAS.mov');

% While video still has frames to process
while hasFrame(vid)
    % read frame
    frame = readFrame(vid);
    
    % grayscale
    frame = rgb2gray(frame);
    
    % binary
    frame = imbinarize(frame);

    % Region of Interest

    % Lane ROI
    lc = [550; 840; 800; 550];
    lr = [740; 300; 1362; 800];

    % Vehicle ROI
    vc = [500;866;868;516];
    vr = [302;302;1450;824];
    
    Lroi = roipoly(frame, lr, lc);
    Vroi = roipoly(frame, vr, vc);
    
    
    
    % Only allow vertical like line (no horizontal
    [R , C] = size(Lroi);
    for i = 1:R
        for j = 1:C
            if Lroi(i,j) == 1
                Lroi(i,j) = frame(i,j);
            else
                Lroi(i,j) = 0;
            end
        end
    end
    
    % Hough Transform
    [H,T,R] = hough(Lroi);

    % Hough Peak
    P = houghpeaks(H, 5,'threshold',ceil(0.5*max(H(:))));
    
    % Locate line and plot on frame
    lines = houghlines(Lroi,T,R,P,'FillGap',1000,'MinLength',30);
    subplot(1,2,1), imshow(frame), hold on
    max_len = 0;

    for k = 1:length(lines)
        % detected point 
        xy = [lines(k).point1; lines(k).point2];
        xy2 = [lines(1).point1; lines(1).point2];

        % Plotting line
        plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','red');
 
        % Plot beginnings and ends of lines
        plot(xy(1,1),xy(1,2),'X','LineWidth',2,'Color','yellow');
        plot(xy(2,1),xy(2,2),'X','LineWidth',2,'Color','yellow');
        
        % retrieve 4 points coordinates and apply polygon
        x = [xy(1,1) xy(1,2); xy(2,1) xy(2,2); xy2(1,1) xy2(1,2); xy2(2,1) xy2(2,2)];
        f = [1 2 3 4];
       
        patch('Faces',f,'Vertices',x,'FaceColor','green')
        
        % Determine the endpoints of the longest line segment
        len = norm(lines(k).point1 - lines(k).point2);
        if ( len > max_len)
            max_len = len;
            xy_long = xy;
        end
        
        % Plot the longest line
        plot(xy_long(1),xy_long(2),'LineWidth',4,'Color','cyan');
        
        % Distance between two points
        distance = sqrt((xy_long(2,1) - xy_long(1,1))^2 + (xy_long(2,2) - xy_long(1,2)^2));

    end 


    % slope of the equation of line
    slope = (xy(2,2)-xy(1,2))/(xy(2,1)-xy(1,1));

    % y-intercept of the line
    b_equ = xy(1,2) - (slope * xy(1,1));
    
    l_equ = (slope * xy(2,1)) + b_equ;
    
    img = imread('ruler.jpg');
    subplot(1,2,2), imshow(img)

end
