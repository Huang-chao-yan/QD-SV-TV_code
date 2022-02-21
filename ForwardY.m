function [dy] = ForwardY(v)

[Ny,Nx,Nc] = size(v);
dy = zeros(size(v));
dy(1:Ny-1,1:Nx-1,:)=( v(2:Ny,1:Nx-1,:) - v(1:Ny-1,1:Nx-1,:) );