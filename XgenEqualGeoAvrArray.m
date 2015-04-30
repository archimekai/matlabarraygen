function [ array ] = XgenEqualGeoAvrArray( geoavr, n, varargin )
%XGENEQUALGEOAVRARRAY 
%   XgenEqualGeoAvrArray( geoavr, n [, lastnumber, minval, maxval  ] )
%   base random function : normrnd
%   parameters:
%   geoavr: the Geometric means of the array to be generated
%   lastnumber:  the last number of the array
%   n: the length of the array
%   minval: the minimum value allowed for each element in the array
%   maxval: the minimum value allowed for each element in the array, this
%       might cause long computing time, use this parameter with caution!
%   by wenkai@Department of Psychology, Peking Universtiy. bliewhale@163.com. 20150425

switch nargin
    case 2
            randpart = n*log(geoavr);
            randratio = random(1,n);
            randratio = randratio / sum(randratio);  % 标准化
            randratio = randpart * randratio;
            array = exp(randratio);
    case 3
        lastnumber = varargin{1};
        randpart = n*log(geoavr) - log(lastnumber);
        randratio = random(1,n-1);
        randratio = randratio / sum(randratio);  % 标准化
        randratio = randpart * randratio;
        array = exp(randratio);
        array(n) = lastnumber;
    case 4
        lastnumber = varargin{1};
        minval = varargin{2}; 
        if minval > 0
            if log(minval)*(n-1) + log(lastnumber)>n*log(geoavr)
                warning('min is too big!\n');
                array = 0;
                return;
            end

            randpart = n*log(geoavr) - log(lastnumber) - (n - 1) * log(minval);
            randratio = random(1,n-1);
            randratio = randratio / sum(randratio);  % 标准化
            randratio = randpart * randratio;
            array = exp(randratio + log(minval));
            array(n) = lastnumber;
        else
            warning('minval must be a positive real number!\n');
            randpart = n*log(geoavr) - log(lastnumber);
            randratio = random(1,n-1);
            randratio = randratio / sum(randratio);  % 标准化
            randratio = randpart * randratio;
            array = exp(randratio);
            array(n) = lastnumber;
        end
    case 5
        lastnumber = varargin{1};
        minval = varargin{2}; 
        maxval = varargin{3};
        array = Inf([1,n]);
        if maxval <= minval
            warning('maxval must be larger than minval!\nWill ignore maxval!\n');
            maxval = Inf;
        end
        while (max(array(1:n - 1)) > maxval)
            if minval > 0
                if log(minval)*(n-1) + log(lastnumber)>n*log(geoavr)
                    warning('min is too big!\n');
                    array = 0;
                    return;
                end

                randpart = n*log(geoavr) - log(lastnumber) - (n - 1) * log(minval);
                randratio = random(1,n-1);
                randratio = randratio / sum(randratio);  % 标准化
                randratio = randpart * randratio;
                array = exp(randratio + log(minval));
                array(n) = lastnumber;
            else
                warning('minval must be a positive real number!\n');
                randpart = n*log(geoavr) - log(lastnumber);
                randratio = random(1,n-1);
                randratio = randratio / sum(randratio);  % 标准化
                randratio = randpart * randratio;
                array = exp(randratio);
                array(n) = lastnumber;
            end
        end
end
end


function x = random(m,n)
    x = normrnd(0.5,0.25,m,n);
    while( min(x)<0 || max(x)>1)
        x = normrnd(0.5,0.25,m,n);
    end        
end

