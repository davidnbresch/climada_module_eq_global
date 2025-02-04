function MMI = MMI_attenuation_calc(mag, dist, dep, correction, a1, a2, a3, a4, b)
% Calculate the attenuation of an earthquake's intensity with distance from
% the epicenter
% MODULE:
% eq_global
% NAME:
%   MMI_attenuation_calc
% PURPOSE:
%   calculate MMI at a given distance from the epicenter 
%
%   WARNING: does NO variable check for speed-up, i.e. ALL parameters need
%   to be defined
% CALLING SEQUENCE:
%   MMI=MMI_attenuation_calc(mag, dist, correction,a1, a2, a3, a4)
% EXAMPLE:
%   MMI=MMI_attenuation_calc(7.44,10.0,1.67,1.67,1.3,0.0026);
%   MMI=MMI_attenuation_calc(8,15.5)   % using default values for
%   depth, correction and the attenuation parameters a1, a2, a3, a4, 
% INPUTS:
%   mag:    magnitude
%   dist:   distance to epicentre [in km] 
% OPTIONAL INPUTS:
%   dep: epicenter depth
%   correction, a1,a2,a3,a4,b: parameters defining an attenuation function
%   of the type MMI = a1 + a2*mag - a3*log(dist+correction) - a4*dist + b*dep
%   where MMI is the Modified Mercalli Intensity at distance dist from the 
%   epicenter and dep is the epicenter depth; log denotes the natural
%   logarithm
%   Have a look at eq_global-master/data/system/attenuation_parameters.xlsx 
%   for a compilation of parameters for selected geographic regions
% OUTPUT:
%   MMI:    the MMI at distance dist from the epicenter (Modified Mercalli
%   Intensity)
% MODIFICATION HISTORY:
% Melanie Bieli, melanie.bieli@bluewin.ch, 20141116
% Melanie Bieli, melanie.bieli@bluewin.ch, 20141209, added correction parameter
% Melanie Bieli, melanie.bieli@bluewin.ch, 20150118, minor clean-up, renaming
% David N. Bresch, dbresch@ethz.ch, 20220616, speed-up, no vars checked
% David N. Bresch, dbresch@ethz.ch, 20220616, speed-up, one line for all

% compute the attenuation equation 
% MMI is kept below a maximum value defined by the equation 
% I_0 = 1.5*(mag - 1), where I_0 is the epicentral intensity (in MMI)
% and mag the Richter magnitude of the earthquake
% Source: Y-X. Hu, S-C. Liu, W. Dong: Earthquake Engineering

% direclty below replaced with one line further below
%maximum_MMI = 1.5*(mag-1);
%MMI = a1 + a2 * mag - a3 * log(dist+correction) - a4 * dist + b*dep;
%if MMI > maximum_MMI, MMI = maximum_MMI; end

MMI = min( ...
    a1 + a2 * mag - a3 * log(dist+correction) - a4 * dist + b*dep, ...
    1.5*(mag-1) );
