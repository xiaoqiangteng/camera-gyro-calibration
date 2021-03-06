%7 point ransac algorithm 11.4
%
% Syntax:
%   [inl,F]= ransac_7_point(P,t,perc)
%
% In:
%   P  - pixel coordinates of all views.
%   t  - treshold for cost.
%   perc - percentage of answers necesary to be chosen.
%  
% Out:
%   inl  - inliers.
%   F - fundamental matrix.
%
% Description:
%   Algorithm 11.4 in the book:
%   Richard Hartley and Andrew Zisserman. 2003. Multiple View Geometry 
%       in Computer Vision (2 ed.). Cambridge University Press, New York,
%       NY, USA
%
% Copyright (C) 2018 Santiago Cortés
%
% This software is distributed under the GNU General Public 
% Licence (version 2 or later); please refer to the file 
% Licence.txt, included with the software, for details.

function [inl,F]= ransac_7_point(P,t,perc)
%7 point ransac, zisserman algorithm 11.4
L=size(P,1);
done =0;
dd=0;
while ~done
    if dd>10
       perc=0.9*perc;
       dd=0;
    end
    if perc*L<10
        inl=[];
        return
    end
    dd=dd+1;
N=randi(size(P,1),1,7);
F=seven_point(P(N,:));
for i=1:size(F,3)
    for j=1:size(P,1)
        m_p1=[P(j,1:2),1];
        m_p2=[P(j,3:4),1];
        m_F=F(:,:,i);
        %d1=(m_F*m_p1').^2;
        %d2=(m_F'*m_p2').^2;
        %d(j,i)=((m_p2*m_F*m_p1').^2)/(d1(1)+d1(2)+d2(1)+d2(2));
        
        e(j,i)=optimal_triangulation_cost(m_p1(1:2),m_p2(1:2),m_F);
        
        1;
    end
end
    [count,inde]=max(sum(e<t));
    if count>(L*perc)
        done=true;
        D=e(:,inde);
        inl=1:size(P,1);
        inl=inl(D<t);
    end
    1;
end


1;

