clear all, close all, clc

vrep=remApi('remoteApi');
vrep.simxFinish(-1);
clientID = vrep.simxStart('127.0.0.1',19997,true,true,5000,5);

if (clientID == -1)
    disp('Not connected!')
end
if (clientID > -1)
    disp('Connected!')
    [res,objs]=vrep.simxGetObjects(clientID,vrep.sim_handle_all,vrep.simx_opmode_oneshot_wait);
    img = [];
    img0 = [];
    [returnCode, copter] = vrep.simxGetObjectHandle(clientID,'Quadricopter_base', vrep.simx_opmode_blocking);
    [returnCode, target] = vrep.simxGetObjectHandle(clientID,'Quadricopter_target', vrep.simx_opmode_blocking);
    [returnCode, anchor0] = vrep.simxGetObjectHandle(clientID,'80cmHighPillar25cm_visible', vrep.simx_opmode_blocking);
    [returnCode, anchor1] = vrep.simxGetObjectHandle(clientID,'80cmHighPillar25cm_visible0', vrep.simx_opmode_blocking);
    [returnCode, anchor2] = vrep.simxGetObjectHandle(clientID,'80cmHighPillar25cm_visible1', vrep.simx_opmode_blocking);
    
    while(1)
        for t=2:2:60
            [returnCode, position] = vrep.simxGetObjectPosition(clientID,copter,-1,vrep.simx_opmode_streaming);
            x_current = position(1)
            y_current = position(2)
            z_current = position(3)
            XYZcoordinate(t-1,1) = x_current
            XYZcoordinate(t-1,2) = y_current
            XYZcoordinate(t-1,3) = z_current;
            z_current = +6.2500e-01;
            
            
            
            [err,camhandle]=vrep.simxGetObjectHandle(clientID,'Vision_sensor',vrep.simx_opmode_oneshot_wait);
            [errorCode,resolution,img]=vrep.simxGetVisionSensorImage2(clientID,camhandle,0,vrep.simx_opmode_oneshot_wait);
            [err,camhandle]=vrep.simxGetObjectHandle(clientID,'Vision_sensor0',vrep.simx_opmode_oneshot_wait);
            [errorCode,resolution,img0]=vrep.simxGetVisionSensorImage2(clientID,camhandle,0,vrep.simx_opmode_oneshot_wait);
            
            if (t==2)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [0.5, 0.5, z_current], vrep.simx_opmode_blocking);
            elseif (t==4)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [-0.8, 1, z_current], vrep.simx_opmode_blocking);
            elseif (t==6)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [-1.1, 1.25, z_current], vrep.simx_opmode_blocking);
            elseif (t==8)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [-1.2, 1.3, z_current], vrep.simx_opmode_blocking);
            elseif (t==10)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [-1.25, 1.3, z_current], vrep.simx_opmode_blocking);
            elseif (t==12)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [-1.25, 1.25, z_current], vrep.simx_opmode_blocking);
            elseif (t==14)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [-1.3, 1, z_current], vrep.simx_opmode_blocking);
            elseif (t==16)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [-1.3, 0.6, z_current], vrep.simx_opmode_blocking);
            elseif (t==18)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [-1.25, 0.2, z_current], vrep.simx_opmode_blocking);
            elseif (t==20)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [-1.2, -0.3, z_current], vrep.simx_opmode_blocking);
            elseif (t==22)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [-1.2, -0.7, z_current], vrep.simx_opmode_blocking);
            elseif (t==24)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [-1.2, -1.2, z_current], vrep.simx_opmode_blocking);
            elseif (t==26)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [-1.2, -1.4, z_current], vrep.simx_opmode_blocking);
            elseif (t==28)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [-1.15, -1.5, z_current], vrep.simx_opmode_blocking);
            elseif (t==30)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [-1.1, -1.3, z_current], vrep.simx_opmode_blocking);
            elseif (t==32)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [-1, -1, z_current], vrep.simx_opmode_blocking);
            elseif (t==34)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [-0.6, -0.8, z_current], vrep.simx_opmode_blocking);
            elseif (t==36)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [-0.2, -0.4, z_current], vrep.simx_opmode_blocking);
            elseif (t==38)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [0.2, 0, z_current], vrep.simx_opmode_blocking);
            elseif (t==40)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [0.6, 0.2, z_current], vrep.simx_opmode_blocking);
            elseif (t==42)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [0.8, 0.5, z_current], vrep.simx_opmode_blocking);
            elseif (t==44)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [0.8, 0.7, z_current], vrep.simx_opmode_blocking);
            elseif (t==46)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [1, 1, z_current], vrep.simx_opmode_blocking);
            elseif (t==48)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [1.2, 1.1, z_current], vrep.simx_opmode_blocking);
            elseif (t==50)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [1.3, 1.2, z_current], vrep.simx_opmode_blocking);
            elseif (t==52)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [1.3, 1.3, z_current], vrep.simx_opmode_blocking);
            elseif (t==54)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [1.25, 1.35, 6.0000e-01], vrep.simx_opmode_blocking);
            elseif (t==56)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [1, 1.3, 6.0000e-01], vrep.simx_opmode_blocking);
            elseif (t==58)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [0.7, 1.2, 6.0000e-01], vrep.simx_opmode_blocking);
            elseif (t==60)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [0, 1.1, 6.0000e-01], vrep.simx_opmode_blocking);
            end
            pause(0.5)
            [returnCode, position] = vrep.simxGetObjectPosition(clientID,copter,-1,vrep.simx_opmode_streaming);
            x_current = position(1);
            y_current = position(2);
            XYZcoordinate(t,1) = x_current;
            XYZcoordinate(t,2) = y_current;
            XYZcoordinate(t-1,3) = z_current;
            z_current = +6.2500e-01;
            
            a0 = [-2;-2]
            a1 = [1.975;-2]
            a2 = [0.05;2.15]
            t = [x_current;y_current]
            d1 = norm(t-a0);
            d2 = norm(t-a1);
            d3 = norm(t-a2);
            A = [2*a0' , -1;...
                2*a1' , -1;...
                2*a2' , -1];
            b = [a0'*a0 - d1^2;...
                a1'*a1 - d2^2;...
                a2'*a2 - d3^2];
            x = inv(A'*A)*A'*b;
            
            figure(1)
            plot(-2,-2,'bo','MarkerSize',15,'LineWidth',2)
            plot(1.975,-2,'bo','MarkerSize',15,'LineWidth',2)
            plot(0.05,2.15,'bo','MarkerSize',15,'LineWidth',2)
            plot(t(1),t(2),'y+','MarkerSize',15,'LineWidth',2)
            plot(x(1),x(2),'ro','MarkerSize',15,'LineWidth',2)
            axis([-2.5 2.5 -2.5 2.5]);
            hold on;

            for i=1:1:15
                hold on
                figure(2)
                [err,camhandle]=vrep.simxGetObjectHandle(clientID,'Vision_sensor',vrep.simx_opmode_oneshot_wait);
                [errorCode,resolution,img]=vrep.simxGetVisionSensorImage2(clientID,camhandle,0,vrep.simx_opmode_oneshot_wait);
                imshow(img)
                hold on
                [err,camhandle]=vrep.simxGetObjectHandle(clientID,'Vision_sensor0',vrep.simx_opmode_oneshot_wait);
                [errorCode,resolution,img0]=vrep.simxGetVisionSensorImage2(clientID,camhandle,0,vrep.simx_opmode_oneshot_wait);
                figure(3)
                imshow(img0)
                pause(0.0125)
            end
        end
        
        %imshow(img)
        %pause(2)
        
    end
    vrep.simxFinish(-1);
end

vrep.delete();