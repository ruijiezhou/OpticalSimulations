function [Pointout] = trajectory(Pointin,Direction,CryLength,CryWid)
%TRAJECTORY 追踪可见光子轨迹

    x_in=Pointin(1);
    y_in=Pointin(2);
    z_in=Pointin(3);
   
    x_Direction=Direction(:,1);
    y_Direction=Direction(:,2);
    z_Direction=Direction(:,3);
    
    x_flag1=abs(x_Direction)./x_Direction;
    y_flag1=abs(y_Direction)./y_Direction;
    z_flag1=abs(z_Direction)./z_Direction;
    
    t_in=(CryLength-z_in.*z_flag1)./abs(z_Direction);
    
    x_Distance=t_in.*x_Direction;
    y_Distance=t_in.*y_Direction;
    z_Distance=CryLength-z_in.*z_flag1;
    Distance=sqrt(x_Distance.^2+y_Distance.^2+z_Distance.^2);
    
    N_x=fix((x_Distance+x_in-(1-x_flag1)/2*CryWid)/CryWid);
    N_y=fix((y_Distance+y_in-(1-y_flag1)/2*CryWid)/CryWid);
    N=abs(N_x)+abs(N_y)+(1-z_flag1)/2;

    x_flag2=mod(N_x,2);
    y_flag2=mod(N_y,2);
    
    x_res=mod(x_Distance+x_in,CryWid);
    y_res=mod(y_Distance+y_in,CryWid);
    
    x_out=CryWid*x_flag2+x_res.*(1-2*x_flag2);
    y_out=CryWid*y_flag2+y_res.*(1-2*y_flag2);
    
    Pointout=[x_out y_out];
end

