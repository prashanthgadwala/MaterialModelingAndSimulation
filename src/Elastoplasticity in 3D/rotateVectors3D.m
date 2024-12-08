% A vector u should be rotated to another vector v.
% the vectors must have the dimensions 3x1.
% see https://en.wikipedia.org/wiki/Rodrigues%27_rotation_formula for details
function[rotMatrix]=rotateVectors3D(u,v)
% first normalize the vectors
u = u/norm(u);
v = v/norm(v);

% compute the angle between the two vectors
rotationAngle=acos(u' * v);

% compute the  axis of rotation
rotationAxis=cross(u,v);
rotationAxis=rotationAxis/norm(rotationAxis);

% compute the skewed rtoation matrix
rotAxisSkewed=[0 -rotationAxis(3) rotationAxis(2); ...
                + rotationAxis(3) 0 -rotationAxis(1); ...
                -rotationAxis(2) rotationAxis(1) 0];

% compute the rotation matrix using Rodrigues' formula                
rotMatrix=eye(3) + sin(rotationAngle)*rotAxisSkewed ...
                + (1-cos(rotationAngle))*rotAxisSkewed*rotAxisSkewed;
