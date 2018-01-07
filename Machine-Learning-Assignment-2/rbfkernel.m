function [k] = rbfkernel(x1,x2,sigma)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
k = exp((-sum(x1'.^2) -sum(x2'.^2) + 2*x1*x2')/(2*sigma^2));
end

