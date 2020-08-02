
clear all, close all, clc

vrep=remApi('remoteApi');
vrep.simxFinish(-1);
clientID = vrep.simxStart('127.0.0.1',19997,true,true,5000,5);
% Setup
[err,camObject1]=vrep.simxGetObjectHandle(clientID,'Vision_sensor',vrep.simx_opmode_oneshot_wait);
[err,camObject2]=vrep.simxGetObjectHandle(clientID,'Vision_sensor0',vrep.simx_opmode_oneshot_wait);

% Figure on which image shown
figure(1),clf,hold on
x=0;
y=0;
if (clientID == -1)
    disp('Not connected!')
else
    disp('Connected!')
    [res,objs]=vrep.simxGetObjects(clientID,vrep.sim_handle_all,vrep.simx_opmode_oneshot_wait);
    while(1)
        figure(1),clf
        % Get Camera Data
        [errorCode,resolution,img1]=vrep.simxGetVisionSensorImage2(clientID,camObject1,0,vrep.simx_opmode_oneshot_wait); 
        [errorCode,resolution,img2]=vrep.simxGetVisionSensorImage2(clientID,camObject2,0,vrep.simx_opmode_oneshot_wait);
        hold on
        subplot(1,2,1);
        imshow(img1)
        hold on
        subplot(1,2,2);
        imshow(img2)
        
        img1_gray = rgb2gray(img1); % Convert to gray
        bw1 = img1_gray < 100; % Convert to binary
        %         imshow(bw1)
        img2_gray = rgb2gray(img2);
        bw2 = img2_gray < 100; % Convert to binary
        %         imshow(bw2)
        
        %THIS IS FOR Y AXIS IN VREP
        stats1 = regionprops('table',bw1,'Centroid','MajorAxisLength','MinorAxisLength'); % Detect circles
        centers1 = stats1.Centroid; % Circle centers
        diameters1 = mean([stats1.MajorAxisLength stats1.MinorAxisLength],2); % Determine circle diameter
        radii1 = diameters1/2; % Circle radii
        if ~isempty(centers1)
            for i = 1:length(centers1(:,1))
                % Show only circles with radius in the range
                
                if (radii1(i) >= 5) && (radii1(i) <= 215)
                    figure(1),hold on, subplot(1,2,1);
                    viscircles(centers1(i,:),radii1(i));    % Draw circle
                    circlenumbers_1=size(centers1);
                    circlenumbers_1=circlenumbers_1(1,1);
                    yyyy=sum(centers1(:,1))/circlenumbers_1;
                    if(circlenumbers_1==1)
                        Yc11=round(centers1(1,1));
                        Yc12=round(centers1(1,2));
                        % Check RGB Values for Color Detection
                        if((img1(Yc11,Yc12,1)>150)&&(img1(Yc11,Yc12,2)<20)&&(img1(Yc11,Yc12,3)<20)) % Red
                            y = -5.5e-1
                            
                        elseif((img1(Yc11,Yc12,1)<20)&&(img1(Yc11,Yc12,2)>150)&&(img1(Yc11,Yc12,3)<20)) % Green
                            y = 3.5e-1
                        elseif((img1(Yc11,Yc12,1)<20)&&(img1(Yc11,Yc12,2)<20)&&(img1(Yc11,Yc12,3)>150)) % Blue
                            y = 1.2
                        elseif((img1(Yc11,Yc12,1)>75)&&(img1(Yc11,Yc12,2)<20)&&(img1(Yc11,Yc12,3)>75)) % Purple
                            y = -1.475
                        end
                        %y=y+(256-yyyy)/10
                        
                    elseif(circlenumbers_1==2)
                        Yc11=round(centers1(1,1));
                        Yc12=round(centers1(1,2));
                        Yc21=round(centers1(2,1));
                        Yc22=round(centers1(2,2));
                        % Check RGB Values for Color Detection
                        if((img1(Yc11,Yc12,1)>75)&&(img1(Yc11,Yc12,2)<20)&&(img1(Yc11,Yc12,3)>75)&&(img1(Yc21,Yc22,1)>150)&&(img1(Yc21,Yc22,2)<20)&&(img1(Yc21,Yc22,3)<20))
                            y = -1.0125 % Between Purple-Red
                        elseif((img1(Yc11,Yc12,1)>150)&&(img1(Yc11,Yc12,2)<20)&&(img1(Yc11,Yc12,3)<20)&&(img1(Yc21,Yc22,1)<20)&&(img1(Yc21,Yc22,2)>150)&&(img1(Yc21,Yc22,3)<20))
                            y = -0.1 % Between Red-Green
                        elseif((img1(Yc11,Yc12,1)<20)&&(img1(Yc11,Yc12,2)>150)&&(img1(Yc11,Yc12,3)<20)&&(img1(Yc21,Yc22,1)<20)&&(img1(Yc21,Yc22,2)<20)&&(img1(Yc21,Yc22,3)>150))
                            y = 0.775 % Between Green-Blue
                        end
                    end
                end
            end
        end
        
        %THIS IS FOR X AXIS IN VREP
        stats2 = regionprops('table',bw2,'Centroid','MajorAxisLength','MinorAxisLength'); % Detect circles
        centers2 = stats2.Centroid; % Circle centers
        diameters2 = mean([stats2.MajorAxisLength stats2.MinorAxisLength],2);
        radii2 = diameters2/2; % Circle radii
        if ~isempty(centers2)
            for i = 1:length(centers2(:,1))
                % Show only circles with radius in the range
                if (radii2(i) >= 5) && (radii2(i) <= 215)
                    figure(1),hold on, subplot(1,2,2);
                    viscircles(centers2(i,:),radii2(i));
                    circlenumbers_2=size(centers2);
                    circlenumbers_2=circlenumbers_2(1,1);
                    xxxx=sum(centers2(:,1))/circlenumbers_2;
                    if(circlenumbers_2==1)
                        Xc11=round(centers2(1,1));
                        Xc12=round(centers2(1,2));
                        % Check RGB Values for Color Detection
                        if((img2(Xc11,Xc12,1)>150)&&(img2(Xc11,Xc12,2)<20)&&(img2(Xc11,Xc12,3)<20)) % Red
                            x= 6e-1
                        elseif((img2(Xc11,Xc12,1)<20)&&(img2(Xc11,Xc12,2)>150)&&(img2(Xc11,Xc12,3)<20)) % Green
                            x= -4.5e-1
                        elseif((img2(Xc11,Xc12,1)<20)&&(img2(Xc11,Xc12,2)<20)&&(img2(Xc11,Xc12,3)>150)) % Blue
                            x= -1.35
                        elseif((img2(Xc11,Xc12,1)>75)&&(img2(Xc11,Xc12,2)<20)&&(img2(Xc11,Xc12,3)>75)) % Purple
                            x= 1.525
                        end
                        %x=x+(256-xxxx)/10
                        
                    elseif(circlenumbers_2==2)
                        Xc11=round(centers2(1,1));
                        Xc12=round(centers2(1,2));
                        Xc21=round(centers2(2,1));
                        Xc22=round(centers2(2,2));
                        % Check RGB Values for Color Detection
                        if((img2(Xc11,Xc12,1)<20)&&(img2(Xc11,Xc12,2)<20)&&(img2(Xc11,Xc12,3)>150)&&(img2(Xc21,Xc22,1)<20)&&(img2(Xc21,Xc22,2)>150)&&(img2(Xc21,Xc22,3)<20))
                            x= -9e-1; % Between Blue-Green
                        elseif((img2(Xc11,Xc12,1)<20)&&(img2(Xc11,Xc12,2)>150)&&(img2(Xc11,Xc12,3)<20)&&(img2(Xc21,Xc22,1)>150)&&(img2(Xc21,Xc22,2)<20)&&(img2(Xc21,Xc22,3)<20))
                            x= 15e-2; % Between Green-Red
                        elseif((img2(Xc11,Xc12,1)>150)&&(img2(Xc11,Xc12,2)<20)&&(img2(Xc11,Xc12,3)<20)&&(img2(Xc21,Xc22,1)>750)&&(img2(Xc21,Xc22,2)<20)&&(img2(Xc21,Xc22,3)>75))
                            x= 1.0625; % Between Red-Purple
                        end
                    end
                end
            end
        end
        figure(2)
        hold on
        plot(x,y,'k+','MarkerSize',14,'LineWidth',3)
        axis([-2.5 2.5 -2.5 2.5]);
        pause(0.25)
    end
end