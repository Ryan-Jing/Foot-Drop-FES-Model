numFrames = 90;  % Number of frames in the animation

% Initialize an empty array called jointDataFtDrop
jointDataFtDrop = [];
jointDataNormal = [];

% Load the angle data from the CSV files
hipAnglesData = csvread('Joint_Data/Hip_Dataset.csv');
jointDataFtDrop(:, 1) = hipAnglesData(1:90, 2);

kneeAnglesData = csvread('Joint_Data/Knee_Dataset.csv');
jointDataFtDrop(:, 2) = kneeAnglesData(1:90, 2);

footAnglesData = csvread('Joint_Data/Foot_Dataset.csv');
jointDataFtDrop(:, 3) = footAnglesData(1:90, 2);

hipAnglesNormalData = csvread('Joint_Data/Hip_Dataset_Normal.csv');
jointDataNormal(:, 1) = hipAnglesNormalData(1:90, 2);

kneeAnglesNormalData = csvread('Joint_Data/Knee_Dataset_Normal.csv');
jointDataNormal(:, 2) = kneeAnglesNormalData(1:90, 2);

footAnglesNormalData = csvread('Joint_Data/Foot_Dataset_Normal.csv');
jointDataNormal(:, 3) = footAnglesNormalData(1:90, 2);

% Define the lengths of the thigh, calf, and foot vectors
thighLength = 3;
footLength = 0.5;
calfLength = 2;
i = 1;

while true
    if i == numFrames
        i = 1;
    end
    % Calculate the positions
    hipJoint = [0, 2];
    thighPosX = hipJoint(1) + thighLength * cosd(jointDataFtDrop(i, 1) - 115);
    thighPosY = hipJoint(2) + thighLength * sind(jointDataFtDrop(i, 1) - 115);
    calfPosX = thighPosX + calfLength * cosd(jointDataFtDrop(i, 2) - 115);
    calfPosY = thighPosY + calfLength * sind(jointDataFtDrop(i, 2) - 115);
    footPosX = calfPosX + footLength * cosd(jointDataFtDrop(i, 3) - 115);
    footPosY = calfPosY + footLength * sind(jointDataFtDrop(i, 3) - 115);

    thighNormalPosX = hipJoint(1) + thighLength * cosd(jointDataNormal(i, 1) - 115);
    thighNormalPosY = hipJoint(2) + thighLength * sind(jointDataNormal(i, 1) - 115);
    calfNormalPosX = thighNormalPosX + calfLength * cosd(jointDataNormal(i, 2) - 115);
    calfNormalPosY = thighNormalPosY + calfLength * sind(jointDataNormal(i, 2) - 115);
    footNormalPosX = calfNormalPosX + footLength * cosd(jointDataNormal(i, 3) - 115);
    footNormalPosY = calfNormalPosY + footLength * sind(jointDataNormal(i, 3) - 115);

    % Plot the vectors
    plot([hipJoint(1), thighPosX, calfPosX, footPosX], [hipJoint(2), thighPosY, calfPosY, footPosY], 'LineWidth', 2);
    hold on;
    plot(thighPosX, thighPosY, 'ro', 'MarkerSize', 10);
    plot(calfPosX, calfPosY, 'ro', 'MarkerSize', 10);
    plot(footPosX, footPosY, 'ro', 'MarkerSize', 10);
    plot([hipJoint(1), thighNormalPosX, calfNormalPosX, footNormalPosX], [hipJoint(2), thighNormalPosY, calfNormalPosY, footNormalPosY], 'LineWidth', 2);
    plot(thighNormalPosX, thighNormalPosY, 'ro', 'MarkerSize', 10, 'color', 'r');
    plot(calfNormalPosX, calfNormalPosY, 'ro', 'MarkerSize', 10, 'color', 'r');
    plot(footNormalPosX, footNormalPosY, 'ro', 'MarkerSize', 10, 'color', 'r');
    hold off;

    % Set the axis limits
    axis([-6 6 -6 6]);

    i = i + 1;
    % Pause for a short duration to create an animation effect
    pause(0.02);
    % Clear the axes for the next frame
    cla;
end
