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
    
    [returnCode, copter] = vrep.simxGetObjectHandle(clientID,'Quadricopter_base', vrep.simx_opmode_blocking);
    [returnCode, target] = vrep.simxGetObjectHandle(clientID,'Quadricopter_target', vrep.simx_opmode_blocking);
    [returnCode, anchor0] = vrep.simxGetObjectHandle(clientID,'80cmHighPillar25cm_visible', vrep.simx_opmode_blocking);
    [returnCode, anchor1] = vrep.simxGetObjectHandle(clientID,'80cmHighPillar25cm_visible0', vrep.simx_opmode_blocking);
    [returnCode, anchor2] = vrep.simxGetObjectHandle(clientID,'80cmHighPillar25cm_visible1', vrep.simx_opmode_blocking);
    figure(2);
    plot(-2,-2,'bo','MarkerSize',15,'LineWidth',2)
    hold on
    figure(2);
    plot(1.975,-2,'bo','MarkerSize',15,'LineWidth',2)
    hold on
    figure(2);
    plot(0.05,2.15,'bo','MarkerSize',15,'LineWidth',2)
    z_current = 0.625;
    while(1)
        for t=2:2:40
            hold on;
            [returnCode, position] = vrep.simxGetObjectPosition(clientID,copter,-1,vrep.simx_opmode_streaming);
            x_current = position(1);
            y_current = position(2);
            XYZcoordinate(t-1,1) = x_current;
            XYZcoordinate(t-1,2) = y_current;
            XYZcoordinate(t-1,3) = z_current;
            figure(2);
            plot(XYZcoordinate(:,1),XYZcoordinate(:,2),'g+','MarkerSize',14,'LineWidth',1.7)
            axis([-2.5 2.5 -2.5 2.5]);
            a0 = [-2;-2]
            a1 = [1.975;-2]
            a2 = [0.05;2.15]
            true = [x_current;y_current]
            d1 = norm(true-a0) + 0.08*randn;
            d2 = norm(true-a1) + 0.08*randn;
            d3 = norm(true-a2) + 0.08*randn;
            A = [2*a0' , -1;...
                2*a1' , -1;...
                2*a2' , -1];
            b = [a0'*a0 - d1^2;...
                a1'*a1 - d2^2;...
                a2'*a2 - d3^2];
            x = inv(A'*A)*A'*b;
            hold on
            figure(2);
            plot(x(1),x(2),'ro','MarkerSize',6,'LineWidth',1.5)
                        
            if (t==2)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [0.5, 0.5, z_current], vrep.simx_opmode_blocking);
            elseif (t==4)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [-0.8, 0.75, z_current], vrep.simx_opmode_blocking);
            elseif (t==6)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [-1.1, 1, z_current], vrep.simx_opmode_blocking);
            elseif (t==8)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [-1.4, 1, z_current], vrep.simx_opmode_blocking);
            elseif (t==10)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [-1.3, 0.6, z_current], vrep.simx_opmode_blocking);
            elseif (t==12)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [-1.25, 0.2, z_current], vrep.simx_opmode_blocking);
            elseif (t==14)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [-1.2, -0.7, z_current], vrep.simx_opmode_blocking);
            elseif (t==16)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [-1.2, -1.2, z_current], vrep.simx_opmode_blocking);
            elseif (t==18)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [-1, -1, z_current], vrep.simx_opmode_blocking);
            elseif (t==20)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [-0.6, -0.8, z_current], vrep.simx_opmode_blocking);
            elseif (t==22)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [-0.2, -0.4, z_current], vrep.simx_opmode_blocking);
            elseif (t==24)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [0.2, 0, z_current], vrep.simx_opmode_blocking);
            elseif (t==26)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [0.6, 0.2, z_current], vrep.simx_opmode_blocking);
            elseif (t==28)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [0.8, 0.5, z_current], vrep.simx_opmode_blocking);
            elseif (t==30)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [0.8, 0.7, z_current], vrep.simx_opmode_blocking);
            elseif (t==32)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [1.3, 1.2, z_current], vrep.simx_opmode_blocking);
            elseif (t==34)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [1.3, 1.3, z_current], vrep.simx_opmode_blocking);
            elseif (t==36)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [1, 1.3, z_current], vrep.simx_opmode_blocking);
            elseif (t==38)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [0.7, 1.2, z_current], vrep.simx_opmode_blocking);
            elseif (t==40)
                target_pos = vrep.simxSetObjectPosition(clientID, target, -1, [0, 1.1, z_current], vrep.simx_opmode_blocking);
            end
            pause(5);
            
            hold on;
            [returnCode, position] = vrep.simxGetObjectPosition(clientID,copter,-1,vrep.simx_opmode_streaming);
            x_current = position(1);
            y_current = position(2);
            XYZcoordinate(t,1) = x_current;
            XYZcoordinate(t,2) = y_current;
            XYZcoordinate(t,3) = z_current;
            figure(2);
            plot(XYZcoordinate(:,1),XYZcoordinate(:,2),'g+','MarkerSize',14,'LineWidth',1.7)
            axis([-5 5 -2.5 2.5]);
            a0 = [-2;-2]
            a1 = [1.975;-2]
            a2 = [0.05;2.15]
            true = [x_current;y_current]
            d1 = norm(true-a0) + 0.08*randn;
            d2 = norm(true-a1) + 0.08*randn;
            d3 = norm(true-a2) + 0.08*randn;
            A = [2*a0' , -1;...
                2*a1' , -1;...
                2*a2' , -1];
            b = [a0'*a0 - d1^2;...
                a1'*a1 - d2^2;...
                a2'*a2 - d3^2];
            x = inv(A'*A)*A'*b;
            hold on
            figure(2);
            plot(x(1),x(2),'ro','MarkerSize',6,'LineWidth',1.5);
            
        end
    end
    vrep.simxFinish(-1);
end

vrep.delete();