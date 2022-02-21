function [dx] = ForwardX(v)

[Ny,Nx,Nc] = size(v);
dx = zeros(size(v));
dx(1:Ny-1,1:Nx-1,:)=( v(1:Ny-1,2:Nx,:) - v(1:Ny-1,1:Nx-1,:) );