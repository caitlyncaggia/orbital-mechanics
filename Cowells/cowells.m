function [positions, velocities] = cowells(videoFileName, T, fps, makePlot)
% Produces a video file of simulated orbits of N bodies based on Cowell's
% method. Inputs are the name of the video file (videoFileName), the number
% of timesteps (T), the number of frames per second (fps) and makePlot
% (boolean to toggle producing video). Outputs are the final positions and
% velocities.

%% Physical Parameters

load planets.mat masses positions velocities N;

%% Simulation Parameters

if makePlot
    vidObj = VideoWriter(videoFileName);
    vidObj.Quality = 100;
    vidObj.FrameRate = fps;
    
    open(vidObj);
    accel = zeros(size(velocities));
    figure('visible','on');
    hold on;
    C = rand(N,3);
end

%% Run Simulation
for tstep = 1:T
    % Calculate Acceleration
    accel = zeros(3,N);
    for i = 1:N
        for j = 1:N
            if i ~= j
                
                d = sqrt((positions(1,j)-positions(1,i))^2 + ...
                    (positions(2,j)-positions(2,i))^2 + ...
                    (positions(3,j)-positions(3,i))^2);
                
                accel(1,i) = (accel(1,i)+(masses(j)*(positions(1,j)...
                    -positions(1,i))) / (d.^3));
                accel(2,i) = (accel(2,i)+(masses(j)*(positions(2,j)...
                    -positions(2,i))) / (d.^3));
                accel(3,i) = (accel(3,i)+(masses(j)*(positions(3,j)...
                    -positions(3,i))) / (d.^3));
            end
        end
        
    end
    
    % Generate Plots
    if makePlot
        % Plot new positions
        scatter3(positions(1,:),positions(2,:),positions(3,:), 36, C, 'filled');
        hold on;
%         scatter3(positions(1,1),positions(2,1),positions(3,1), ... Sun
%             'r','filled');
%         scatter3(positions(1,4),positions(2,4),positions(3,4), ... Earth
%             'g', 'filled');
%         scatter3(positions(1,5),positions(2,5),positions(3,5), ... Moon
%             1, [0.5 0.5 0.5], '.', 'filled');
        
        % Axis limits
        ylim([-25,25]);
        xlim([-25,25]);
        zlim([-25,25]);
        writeVideo(vidObj,getframe(gcf));
        close(gcf);
    end
    
    % Update Positions and Velocities
    positions(:,:) = positions + velocities;
    velocities(:,:) = velocities + accel;
    
end

if makePlot
    close(vidObj);
end


end

