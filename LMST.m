clear all;
    for i = 1:5
      x_target(i) = 5+randn(1);%randi(3)*randi(3);%randsrc(1)*randi(3);
      y_target(i) = 5+randn(1);%randi(3)*randi(3);%randsrc(1)*randi(3);
      x = rand(1)
      y = rand(1)
      X(i) = x;
      Y(i) = y;
    end
    
  K = 1;
  
  fid = figure;
  hold on
  writerObj = VideoWriter('out.avi'); 
  writerObj.FrameRate = 2; 
  open(writerObj); 

  
for e = 1:15
  %while(abs(X(1)-x_target(1))>0.0005||abs(Y(1)-y_target(1))>0.0005)
    %LMST part
    for i = 1:5
        for j = 1:5
           weight(i,j) = 100*sqrt((X(i)-X(j))^2+(Y(i)-Y(j))^2);
        end
        total(i) = weight(i,1)+weight(i,2)+weight(i,3)+weight(i,4)+weight(i,5);
    end
    
    for i =1:5
        l(i) = max(find(total==min(total)));
        L(i) = l(i);
        total(l(i)) = inf;
    end
    
    x1 = [L(1),L(1),L(1),L(1),L(2),L(2),L(3),L(4)];
    y1 = [L(2),L(3),L(4),L(5),L(3),L(5),L(4),L(5)];
    weights = [weight(L(1),L(2)),weight(L(1),L(3)),weight(L(1),L(4)),weight(L(1),L(5)),weight(L(2),L(3)),weight(L(2),L(5)),weight(L(3),L(4)),weight(L(4),L(5))];

     %figure;
     G = graph(x1,y1,weights);
     %p = plot(G,'EdgeLabel',G.Edges.Weight);
     [T,pred] = minspantree(G);
     %highlight(p,T);
     
     
     for i = 2:5
       if(pred(i)>i)
         n(i-1,e) = i;
         m(i-1,e) = pred(i);
       else
         n(i-1,e) = pred(i);
         m(i-1,e) = i;
       end
     end
     
     number1 = 0;
     number2 = 0;
     number3 = 0;
     number4 = 0;
     number5 = 0;
     for j = 1:4
 
         if(n(j,e) == 1)
             number1 = number1 + 1;
             n_1(number1,e) = n(j,e);
             m_1(number1,e) = m(j,e);
         end
         if(n(j,e) == 2 || m(j,e) == 2)
             number2 = number2 + 1;
             n_2(number2,e) = n(j,e);
             m_2(number2,e) = m(j,e); 
         end
         if(n(j,e) == 3 || m(j,e) == 3)
             number3 = number3 + 1;
             n_3(number3,e) = n(j,e);
             m_3(number3,e) = m(j,e);
         end
         if(n(j,e) == 4 || m(j,e) == 4)
             number4 = number4 + 1;
             n_4(number4,e) = n(j,e);
             m_4(number4,e) = m(j,e);
         end
         if(m(j,e) == 5)
             number5 = number5 + 1;
             n_5(number5,e) = n(j,e);
             m_5(number5,e) = m(j,e);
         end
   
     end
       pause(0.05);
       figure(fid);
       
      %figure; 
     for j = 1:5
       theta = 0:1:360;
       Circle1=X(j)+1*cosd(theta);
       Circle2=Y(j)+1*sind(theta);
       plot(Circle1,Circle2,'black','linewidth',1);
       axis equal
       hold on;
     end
     
    syms a b;
    r = 1;
    plot(x_target(1:5),y_target(1:5),'+','markersize',10);
    text(x_target(1),y_target(1),'target1','FontSize',12);
    text(x_target(2),y_target(2),'target2','FontSize',12);
    text(x_target(3),y_target(3),'target3','FontSize',12);
    text(x_target(4),y_target(4),'target4','FontSize',12);
    text(x_target(5),y_target(5),'target5','FontSize',12);
    hold on
    
    plot(X(1:5),Y(1:5),'+','markersize',10);
    text(X(1),Y(1),'node1','FontSize',12);
    text(X(2),Y(2),'node2','FontSize',12);
    text(X(3),Y(3),'node3','FontSize',12);
    text(X(4),Y(4),'node4','FontSize',12);
    text(X(5),Y(5),'node5','FontSize',12);
        
    %roots of each two circles
    
    for i = 1:4
      for j = (i+1):5
       S = solve((a-X(i))^2+(b-Y(i))^2-r^2,(a-X(j))^2+(b-Y(j))^2-r^2,a,b);    
       root_x1(i,j) = double(S.a(1));
       root_x2(i,j) = double(S.a(2));
       root_y1(i,j) = double(S.b(1));
       root_y2(i,j) = double(S.b(2));
       
       if((root_x1(i,j)~=0)&&(root_x2(i,j)~=0)&&(root_y1(i,j)~=0)&&(root_y2(i,j)~=0))
         plot(root_x1(i,j),root_y1(i,j));
         plot(root_x2(i,j),root_y2(i,j));
         
         x1_angle(i,j) = double(acosd(root_x1(i,j)-X(i)));
         y1_angle(i,j) = double(asind(root_y1(i,j)-Y(i)));
         x2_angle(i,j) = double(acosd(root_x2(i,j)-X(i)));
         y2_angle(i,j) = double(asind(root_y2(i,j)-Y(i)));
         
         x3_angle(i,j) = double(acosd(root_x1(i,j)-X(j)));
         y3_angle(i,j) = double(asind(root_y1(i,j)-Y(j)));
         x4_angle(i,j) = double(acosd(root_x2(i,j)-X(j)));
         y4_angle(i,j) = double(asind(root_y2(i,j)-Y(j)));
                     
               if(y1_angle(i,j)<0)
                  if(x1_angle(i,j) > 90)
                     x1_angle(i,j) = 360 - x1_angle(i,j);
                     y1_angle(i,j) = 180 - y1_angle(i,j);
                  else
                     x1_angle(i,j) = 360 - x1_angle(i,j);
                     y1_angle(i,j) = 360 + y1_angle(i,j);
                  end
               else
                  if(x1_angle(i,j)>90)
                    y1_angle(i,j) = x1_angle(i,j);
                  end      
               end      
           
               if(y2_angle(i,j)<0)
                  if(x2_angle(i,j) > 90)
                     x2_angle(i,j) = 360 - x2_angle(i,j);
                     y2_angle(i,j) = 180 - y2_angle(i,j);
                  else
                     x2_angle(i,j) = 360 - x2_angle(i,j);
                     y2_angle(i,j) = 360 + y2_angle(i,j);
                  end
               else
                  if(x2_angle(i,j)>90)
                    y2_angle(i,j) = x2_angle(i,j);
                  end      
               end  
               
               if(y3_angle(i,j)<0)
                  if(x3_angle(i,j) > 90)
                     x3_angle(i,j) = 360 - x3_angle(i,j);
                     y3_angle(i,j) = 180 - y3_angle(i,j);
                  else
                     x3_angle(i,j) = 360 - x3_angle(i,j);
                     y3_angle(i,j) = 360 + y3_angle(i,j);
                  end
               else
                  if(x3_angle(i,j)>90)
                    y3_angle(i,j) = x3_angle(i,j);
                  end      
               end 
               
                if(y4_angle(i,j)<0)
                  if(x4_angle(i,j) > 90)
                     x4_angle(i,j) = 360 - x4_angle(i,j);
                     y4_angle(i,j) = 180 - y4_angle(i,j);
                  else
                     x4_angle(i,j) = 360 - x4_angle(i,j);
                     y4_angle(i,j) = 360 + y4_angle(i,j);
                  end
               else
                  if(x4_angle(i,j)>90)
                    y4_angle(i,j) = x4_angle(i,j);
                  end      
               end 
               
              angle1 = [x1_angle(i,j) x2_angle(i,j) y1_angle(i,j) y2_angle(i,j)];
              if((max(angle1)-min(angle1))<180)
                   theta2(:,K) = linspace(min(angle1),max(angle1),10);
              else
                   theta2(:,K) = linspace(max(angle1),360+min(angle1),10);
              end
              
              for k = 1:10
                  C1(k) = X(i) + 1*cosd(theta2(k,K));
                  C2(k) = Y(i) + 1*sind(theta2(k,K));
                  Distance1(k,K) = sqrt((C1(k)-x_target(1))^2+(C2(k)-y_target(1))^2);
                  Distance2(k,K) = sqrt((C1(k)-x_target(2))^2+(C2(k)-y_target(2))^2);
                  Distance3(k,K) = sqrt((C1(k)-x_target(3))^2+(C2(k)-y_target(3))^2);
                  Distance4(k,K) = sqrt((C1(k)-x_target(4))^2+(C2(k)-y_target(4))^2);
                  Distance5(k,K) = sqrt((C1(k)-x_target(5))^2+(C2(k)-y_target(5))^2);
              end
              
                 C1=X(i)+1*cosd(theta2(:,K));
                 C2=Y(i)+1*sind(theta2(:,K));
                 %plot(C1,C2,'b+');
                 %plot(C1,C2,'r','linewidth',10);
                 axis equal
                 hold on;
              
              angle2 = [x3_angle(i,j) x4_angle(i,j) y3_angle(i,j) y4_angle(i,j)];
              if((max(angle2)-min(angle2))<180)
                  theta3(:,K) = linspace(min(angle2)+5,max(angle2)-5,10);
              else
                  theta3(:,K) = linspace(max(angle2)+5,360+min(angle2)-5,10);
              end
              
              for k = 1:10
                  C3(k) = X(j) + 1*cosd(theta3(k,K));
                  C4(k) = Y(j) + 1*sind(theta3(k,K));
                  Distance1(k+10,K) = sqrt((C3(k)-x_target(1))^2+(C4(k)-y_target(1))^2);
                  Distance2(k+10,K) = sqrt((C3(k)-x_target(2))^2+(C4(k)-y_target(2))^2);
                  Distance3(k+10,K) = sqrt((C3(k)-x_target(3))^2+(C4(k)-y_target(3))^2);
                  Distance4(k+10,K) = sqrt((C3(k)-x_target(4))^2+(C4(k)-y_target(4))^2);
                  Distance5(k+10,K) = sqrt((C3(k)-x_target(5))^2+(C4(k)-y_target(5))^2);
              end
              
                 C3=X(j)+1*cosd(theta3(:,K));
                 C4=Y(j)+1*sind(theta3(:,K));
                 %plot(C3,C4,'b+');
                 %plot(C3,C4,'r','linewidth',10);
                 axis equal
                 hold on;    
 
              K = K + 1;
       end
        
      end
    end
   %round short-term position to target1
         if(number1 > 1)
              for i = 1:number1
                  if(m_1(i,e) == 2)
                   [Row1 Column1] = find(Distance1==min(min(Distance1(:,1))));
                   row1(i) = Row1(1);
                     if(row1(i)>10)
                        p_x1(i) = X(2) + 1*cosd(theta3(row1(i)-10,1));
                        p_y1(i) = Y(2) + 1*sind(theta3(row1(i)-10,1));
                        distance1(i) = sqrt((p_x1(i)-x_target(1))^2+(p_y1(i)-y_target(1))^2);
                     else
                        p_x1(i) = X(1) + 1*cosd(theta2(row1(i),1));
                        p_y1(i) = Y(1) + 1*sind(theta2(row1(i),1));
                        distance1(i) = sqrt((p_x1(i)-x_target(1))^2+(p_y1(i)-y_target(1))^2);
                     end
                 
                  elseif(m_1(i,e) == 3)
                   [Row1 Column1] = find(Distance1==min(min(Distance1(:,2))));
                   row1(i) = Row1(1);
                     if(row1(i)>10)
                        p_x1(i) = X(3) + 1*cosd(theta3(row1(i)-10,2));
                        p_y1(i) = Y(3) + 1*sind(theta3(row1(i)-10,2));
                        distance1(i) = sqrt((p_x1(i)-x_target(1))^2+(p_y1(i)-y_target(1))^2);
                     else
                        p_x1(i) = X(1) + 1*cosd(theta2(row1(i),2));
                        p_y1(i) = Y(1) + 1*sind(theta2(row1(i),2));
                        distance1(i) = sqrt((p_x1(i)-x_target(1))^2+(p_y1(i)-y_target(1))^2);
                     end
                 
                  elseif(m_1(i,e) == 4)
                   [Row1 Column1] = find(Distance1==min(min(Distance1(:,3))));
                   row1(i) = Row1(1);
                     if(row1(i)>10)
                        p_x1(i) = X(4) + 1*cosd(theta3(row1(i)-10,3));
                        p_y1(i) = Y(4) + 1*sind(theta3(row1(i)-10,3));
                        distance1(i) = sqrt((p_x1(i)-x_target(1))^2+(p_y1(i)-y_target(1))^2);
                     else
                        p_x1(i) = X(1) + 1*cosd(theta2(row1(i),3));
                        p_y1(i) = Y(1) + 1*sind(theta2(row1(i),3));
                        distance1(i) = sqrt((p_x1(i)-x_target(1))^2+(p_y1(i)-y_target(1))^2);
                     end
                 
                  elseif(m_1(i,e) == 5)
                   [Row1 Column1] = find(Distance1==min(min(Distance1(:,4))));
                   row1(i) = Row1(1);
                     if(row1(i)>10)
                        p_x1(i) = X(5) + 1*cosd(theta3(row1(i)-10,4));
                        p_y1(i) = Y(5) + 1*sind(theta3(row1(i)-10,4));
                        distance1(i) = sqrt((p_x1(i)-x_target(1))^2+(p_y1(i)-y_target(1))^2);
                     else
                        p_x1(i) = X(1) + 1*cosd(theta2(row1(i),4));
                        p_y1(i) = Y(1) + 1*sind(theta2(row1(i),4));
                        distance1(i) = sqrt((p_x1(i)-x_target(1))^2+(p_y1(i)-y_target(1))^2);
                     end
                  end
              end
             [w1] = find(distance1==min(distance1));
             p_x(1,e) = p_x1(w1(1));
             p_y(1,e) = p_y1(w1(1));
        else
                  if(m_1(1,e) == 2)
                   [Row1 Column1] = find(Distance1==min(min(Distance1(:,1))));
                   row1 = Row1(1);
                     if(row1>10)
                        p_x1 = X(2) + 1*cosd(theta3(row1-10,1));
                        p_y1 = Y(2) + 1*sind(theta3(row1-10,1));
                        
                     else
                        p_x1 = X(1) + 1*cosd(theta2(row1,1));
                        p_y1 = Y(1) + 1*sind(theta2(row1,1));
                        
                     end
                 
                  elseif(m_1(1,e) == 3)
                   [Row1 Column1] = find(Distance1==min(min(Distance1(:,2))));
                   row1 = Row1(1);
                     if(row1>10)
                        p_x1 = X(3) + 1*cosd(theta3(row1-10,2));
                        p_y1 = Y(3) + 1*sind(theta3(row1-10,2));
                        
                     else
                        p_x1 = X(1) + 1*cosd(theta2(row1,2));
                        p_y1 = Y(1) + 1*sind(theta2(row1,2));
                        
                     end
                 
                  elseif(m_1(1,e) == 4)
                   [Row1 Column1] = find(Distance1==min(min(Distance1(:,3))));
                   row1 = Row1(1);
                     if(row1>10)
                        p_x1 = X(4) + 1*cosd(theta3(row1-10,3));
                        p_y1 = Y(4) + 1*sind(theta3(row1-10,3));
                        
                     else
                        p_x1 = X(1) + 1*cosd(theta2(row1,3));
                        p_y1 = Y(1) + 1*sind(theta2(row1,3));
                        
                     end
                  
                  elseif(m_1(1,e) == 5)
                   [Row1 Column1] = find(Distance1==min(min(Distance1(:,4))));
                   row1 = Row1(1);
                     if(row1>10)
                        p_x1 = X(5) + 1*cosd(theta3(row1-10,4));
                        p_y1 = Y(5) + 1*sind(theta3(row1-10,4));
                        
                     else
                        p_x1 = X(1) + 1*cosd(theta2(row1,4));
                        p_y1 = Y(1) + 1*sind(theta2(row1,4));
                        
                     end
                  end
             p_x(1,e) = p_x1(1);
             p_y(1,e) = p_y1(1);
         end
             
%round short-term position to target2
           if(number2>1)
              for i = 1:number2
                  if(m_2(i,e) == 3)
                   [Row2 Column2] = find(Distance2==min(min(Distance2(:,5))));
                   row2(i) = Row2(1);
                     if(row2(i)>10)
                        p_x2(i) = X(3) + 1*cosd(theta3(row2(i)-10,5));
                        p_y2(i) = Y(3) + 1*sind(theta3(row2(i)-10,5));
                        distance2(i) = sqrt((p_x2(i)-x_target(2))^2+(p_y2(i)-y_target(2))^2);
                     else
                        p_x2(i) = X(2) + 1*cosd(theta2(row2(i),5));
                        p_y2(i) = Y(2) + 1*sind(theta2(row2(i),5));
                        distance2(i) = sqrt((p_x2(i)-x_target(2))^2+(p_y2(i)-y_target(2))^2);
                     end
                  
                  elseif(m_2(i,e) == 4)
                   [Row2 Column2] = find(Distance2==min(min(Distance2(:,6))));
                   row2(i) = Row2(1);
                     if(row2(i)>10)
                        p_x2(i) = X(4) + 1*cosd(theta3(row2(i)-10,6));
                        p_y2(i) = Y(4) + 1*sind(theta3(row2(i)-10,6));
                        distance2(i) = sqrt((p_x2(i)-x_target(2))^2+(p_y2(i)-y_target(2))^2);
                     else
                        p_x2(i) = X(2) + 1*cosd(theta2(row2(i),6));
                        p_y2(i) = Y(2) + 1*sind(theta2(row2(i),6));
                        distance2(i) = sqrt((p_x2(i)-x_target(2))^2+(p_y2(i)-y_target(2))^2);
                     end
                  
                  elseif(m_2(i,e) == 5)
                   [Row2 Column2] = find(Distance2==min(min(Distance2(:,7))));
                   row2(i) = Row2(1);
                    if(row2(i)>10)
                        p_x2(i) = X(5) + 1*cosd(theta3(row2(i)-10,7));
                        p_y2(i) = Y(5) + 1*sind(theta3(row2(i)-10,7));
                        distance2(i) = sqrt((p_x2(i)-x_target(2))^2+(p_y2(i)-y_target(2))^2);
                     else
                        p_x2(i) = X(2) + 1*cosd(theta2(row2(i),7));
                        p_y2(i) = Y(2) + 1*sind(theta2(row2(i),7));
                        distance2(i) = sqrt((p_x2(i)-x_target(2))^2+(p_y2(i)-y_target(2))^2);
                     end
                  
                  elseif(n_2(i,e) == 1)
                   [Row2 Column2] = find(Distance2==min(min(Distance2(:,1))));
                   row2(i) = Row2(1);
                     if(row2(i)>10)
                        p_x2(i) = X(2) + 1*cosd(theta3(row2(i)-10,1));
                        p_y2(i) = Y(2) + 1*sind(theta3(row2(i)-10,1));
                        distance2(i) = sqrt((p_x2(i)-x_target(2))^2+(p_y2(i)-y_target(2))^2);
                     else
                        p_x2(i) = X(1) + 1*cosd(theta2(row2(i),1));
                        p_y2(i) = Y(1) + 1*sind(theta2(row2(i),1));
                        distance2(i) = sqrt((p_x2(i)-x_target(2))^2+(p_y2(i)-y_target(2))^2);
                     end
                  end
              end
             [w2] = find(distance2==min(distance2));
             p_x(2,e) = p_x2(w2(1));
             p_y(2,e) = p_y2(w2(1));
              
           else
                  if(m_2(1,e) == 3)
                   [Row2 Column2] = find(Distance2==min(min(Distance2(:,5))));
                   row2 = Row2(1);
                     if(row2>10)
                        p_x2 = X(3) + 1*cosd(theta3(row2-10,5));
                        p_y2 = Y(3) + 1*sind(theta3(row2-10,5));
                        
                     else
                        p_x2 = X(2) + 1*cosd(theta2(row2,5));
                        p_y2 = Y(2) + 1*sind(theta2(row2,5));
                        
                     end
                 
                  elseif(m_2(1,e) == 4)
                   [Row2 Column2] = find(Distance2==min(min(Distance2(:,6))));
                   row2 = Row2(1);
                     if(row2>10)
                        p_x2 = X(4) + 1*cosd(theta3(row2-10,6));
                        p_y2 = Y(4) + 1*sind(theta3(row2-10,6));
                        
                     else
                        p_x2 = X(2) + 1*cosd(theta2(row2,6));
                        p_y2 = Y(2) + 1*sind(theta2(row2,6));
                        
                     end
                  
                  elseif(m_2(1,e) == 5)
                   [Row2 Column2] = find(Distance2==min(min(Distance2(:,7))));
                   row2 = Row2(1);
                    if(row2>10)
                        p_x2 = X(5) + 1*cosd(theta3(row2-10,7));
                        p_y2 = Y(5) + 1*sind(theta3(row2-10,7));
                       
                     else
                        p_x2 = X(2) + 1*cosd(theta2(row2,7));
                        p_y2 = Y(2) + 1*sind(theta2(row2,7));
                        
                     end
                  
                  elseif(n_2(1,e) == 1)
                   [Row2 Column2] = find(Distance2==min(min(Distance2(:,1))));
                   row2 = Row2(1);
                     if(row2>10)
                        p_x2 = X(2) + 1*cosd(theta3(row2-10,1));
                        p_y2 = Y(2) + 1*sind(theta3(row2-10,1));
                        
                     else
                        p_x2 = X(1) + 1*cosd(theta2(row2,1));
                        p_y2 = Y(1) + 1*sind(theta2(row2,1));
                        
                     end
                  end
             p_x(2,e) = p_x2(1);
             p_y(2,e) = p_y2(1);
           end

%round short-term position to target3  
         if(number3 > 1)
              for i = 1:number3
                  if(n_3(i,e) == 1)
                   [Row3 Column3] = find(Distance3==min(min(Distance3(:,2))));
                   row3(i) = Row3(1);
                     if(row3(i)>10)
                        p_x3(i) = X(3) + 1*cosd(theta3(row3(i)-10,2));
                        p_y3(i) = Y(3) + 1*sind(theta3(row3(i)-10,2));
                        distance3(i) = sqrt((p_x3(i)-x_target(3))^2+(p_y3(i)-y_target(3))^2);
                     else
                        p_x3(i) = X(1) + 1*cosd(theta2(row3(i),2));
                        p_y3(i) = Y(1) + 1*sind(theta2(row3(i),2));
                        distance3(i) = sqrt((p_x3(i)-x_target(3))^2+(p_y3(i)-y_target(3))^2);
                     end
                  
                  elseif(n_3(i,e) == 2)
                   [Row3 Column3] = find(Distance3==min(min(Distance3(:,5))));
                   row3(i) = Row3(1);
                     if(row3(i)>10)
                        p_x3(i) = X(3) + 1*cosd(theta3(row3(i)-10,5));
                        p_y3(i) = Y(3) + 1*sind(theta3(row3(i)-10,5));
                        distance3(i) = sqrt((p_x3(i)-x_target(3))^2+(p_y3(i)-y_target(3))^2);
                     else
                        p_x3(i) = X(2) + 1*cosd(theta2(row3(i),5));
                        p_y3(i) = Y(2) + 1*sind(theta2(row3(i),5));
                        distance3(i) = sqrt((p_x3(i)-x_target(3))^2+(p_y3(i)-y_target(3))^2);
                     end
                
                  elseif(m_3(i,e) == 4)
                   [Row3 Column3] = find(Distance3==min(min(Distance3(:,8))));
                   row3(i) = Row3(1);
                     if(row3(i)>10)
                        p_x3(i) = X(4) + 1*cosd(theta3(row3(i)-10,8));
                        p_y3(i) = Y(4) + 1*sind(theta3(row3(i)-10,8));
                        distance3(i) = sqrt((p_x3(i)-x_target(3))^2+(p_y3(i)-y_target(3))^2);
                     else
                        p_x3(i) = X(3) + 1*cosd(theta2(row3(i),8));
                        p_y3(i) = Y(3) + 1*sind(theta2(row3(i),8));
                        distance3(i) = sqrt((p_x3(i)-x_target(3))^2+(p_y3(i)-y_target(3))^2);
                     end
                 
                  elseif(m_3(i,e) == 5)
                   [Row3 Column3] = find(Distance3==min(Distance3(:,9)));
                   row3(i) = Row3(1);
                     if(row3(i)>10)
                        p_x3(i) = X(5) + 1*cosd(theta3(row3(i)-10,9));
                        p_y3(i) = Y(5) + 1*sind(theta3(row3(i)-10,9));
                        distance3(i) = sqrt((p_x3(i)-x_target(3))^2+(p_y3(i)-y_target(3))^2);
                     else
                        p_x3(i) = X(3) + 1*cosd(theta2(row3(i),9));
                        p_y3(i) = Y(3) + 1*sind(theta2(row3(i),9));
                        distance3(i) = sqrt((p_x3(i)-x_target(3))^2+(p_y3(i)-y_target(3))^2);
                     end
                  end
              end
             [w3] = find(distance3==min(distance3));
             p_x(3,e) = p_x3(w3(1));
             p_y(3,e) = p_y3(w3(1));
         else
                 if(n_3(1,e) == 1)
                   [Row3 Column3] = find(Distance3==min(min(Distance3(:,2))));
                   row3 = Row3(1);
                     if(row3>10)
                        p_x3 = X(3) + 1*cosd(theta3(row3-10,2));
                        p_y3 = Y(3) + 1*sind(theta3(row3-10,2));
                        
                     else
                        p_x3 = X(1) + 1*cosd(theta2(row3,2));
                        p_y3 = Y(1) + 1*sind(theta2(row3,2));
                       
                     end
                 
                 elseif(n_3(1,e) == 2)
                   [Row3 Column3] = find(Distance3==min(min(Distance3(:,5))));
                   row3 = Row3(1);
                     if(row3>10)
                        p_x3 = X(3) + 1*cosd(theta3(row3-10,5));
                        p_y3 = Y(3) + 1*sind(theta3(row3-10,5));
                        
                     else
                        p_x3 = X(2) + 1*cosd(theta2(row3,5));
                        p_y3 = Y(2) + 1*sind(theta2(row3,5));
                        
                     end
                  
                 elseif(m_3(1,e) == 4)
                   [Row3 Column3] = find(Distance3==min(min(Distance3(:,8))));
                   row3 = Row3(1);
                     if(row3>10)
                        p_x3 = X(4) + 1*cosd(theta3(row3-10,8));
                        p_y3 = Y(4) + 1*sind(theta3(row3-10,8));
                        
                     else
                        p_x3 = X(3) + 1*cosd(theta2(row3,8));
                        p_y3 = Y(3) + 1*sind(theta2(row3,8));
                        
                     end
                  
                 elseif(m_3(1,e) == 5)
                   [Row3 Column3] = find(Distance3==min(min(Distance3(:,9))));
                   row3 = Row3(1);
                     if(row3>10)
                        p_x3 = X(5) + 1*cosd(theta3(row3-10,9));
                        p_y3 = Y(5) + 1*sind(theta3(row3-10,9));
                        
                     else
                        p_x3 = X(3) + 1*cosd(theta2(row3(1),9));
                        p_y3 = Y(3) + 1*sind(theta2(row3(1),9));
                        
                     end
                 end
             p_x(3,e) = p_x3(1);
             p_y(3,e) = p_y3(1);
          end
             
             
             
%round short-term position to target4
          if(number4 > 1)
              for i = 1:number4
                  if(n_4(i,e) == 1)
                   [Row4 Column4] = find(Distance4==min(min(Distance4(:,3))));
                   row4(i) = Row4(1);
                    if(row4(i)>10)
                        p_x4(i) = X(4) + 1*cosd(theta3(row4(i)-10,3));
                        p_y4(i) = Y(4) + 1*sind(theta3(row4(i)-10,3));
                        distance4(i) = sqrt((p_x4(i)-x_target(4))^2+(p_y4(i)-y_target(4))^2);
                     else
                        p_x4(i) = X(1) + 1*cosd(theta2(row4(i),3));
                        p_y4(i) = Y(1) + 1*sind(theta2(row4(i),3));
                        distance4(i) = sqrt((p_x4(i)-x_target(4))^2+(p_y4(i)-y_target(4))^2);
                     end
                  
                  elseif(n_4(i,e) == 2)
                   [Row4 Column4] = find(Distance4==min(min(Distance4(:,6))));
                   row4(i) = Row4(1);
                     if(row4(i)>10)
                        p_x4(i) = X(4) + 1*cosd(theta3(row4(i)-10,6));
                        p_y4(i) = Y(4) + 1*sind(theta3(row4(i)-10,6));
                        distance4(i) = sqrt((p_x4(i)-x_target(4))^2+(p_y4(i)-y_target(4))^2);
                     else
                        p_x4(i) = X(2) + 1*cosd(theta2(row4(i),6));
                        p_y4(i) = Y(2) + 1*sind(theta2(row4(i),6));
                        distance4(i) = sqrt((p_x4(i)-x_target(4))^2+(p_y4(i)-y_target(4))^2);
                     end
                  
                  elseif(n_4(i,e) == 3)
                   [Row4 Column4] = find(Distance4==min(min(Distance4(:,8))));
                   row4(i) = Row4(1);
                     if(row4(i)>10)
                        p_x4(i) = X(4) + 1*cosd(theta3(row4(i)-10,8));
                        p_y4(i) = Y(4) + 1*sind(theta3(row4(i)-10,8));
                        distance4(i) = sqrt((p_x4(i)-x_target(4))^2+(p_y4(i)-y_target(4))^2);
                     else
                        p_x4(i) = X(3) + 1*cosd(theta2(row4(i),8));
                        p_y4(i) = Y(3) + 1*sind(theta2(row4(i),8));
                        distance4(i) = sqrt((p_x4(i)-x_target(4))^2+(p_y4(i)-y_target(4))^2);
                     end
                  
                  elseif(m_4(i,e) == 5)
                   [Row4 Column4] = find(Distance4==min(min(Distance4(:,10))));
                   row4(i) = Row4(1);
                     if(row4(i)>10)
                        p_x4(i) = X(5) + 1*cosd(theta3(row4(i)-10,10));
                        p_y4(i) = Y(5) + 1*sind(theta3(row4(i)-10,10));
                        distance4(i) = sqrt((p_x4(i)-x_target(4))^2+(p_y4(i)-y_target(4))^2);
                     else
                        p_x4(i) = X(4) + 1*cosd(theta2(row4(i),10));
                        p_y4(i) = Y(4) + 1*sind(theta2(row4(i),10));
                        distance4(i) = sqrt((p_x4(i)-x_target(4))^2+(p_y4(i)-y_target(4))^2);
                     end
                  end
              end
             [w4] = find(distance4==min(distance4));
             p_x(4,e) = p_x4(w4(1));
             p_y(4,e) = p_y4(w4(1));
        else
                  if(n_4(1,e) == 1)
                   [Row4 Column4] = find(Distance4==min(min(Distance4(:,3))));
                   row4 = Row4(1);
                    if(row4>10)
                        p_x4 = X(4) + 1*cosd(theta3(row4-10,3));
                        p_y4 = Y(4) + 1*sind(theta3(row4-10,3));
                        
                     else
                        p_x4 = X(1) + 1*cosd(theta2(row4,3));
                        p_y4 = Y(1) + 1*sind(theta2(row4,3));
                        
                     end
                 
                  elseif(n_4(1,e) == 2)
                   [Row4 Column4] = find(Distance4==min(min(Distance4(:,6))));
                   row4 = Row4(1);
                     if(row4>10)
                        p_x4 = X(4) + 1*cosd(theta3(row4-10,6));
                        p_y4 = Y(4) + 1*sind(theta3(row4-10,6));
                        
                     else
                        p_x4 = X(2) + 1*cosd(theta2(row4,6));
                        p_y4 = Y(2) + 1*sind(theta2(row4,6));
                        
                     end
                  
                  elseif(n_4(1,e) == 3)
                   [Row4 Column4] = find(Distance4==min(min(Distance4(:,8))));
                   row4 = Row4(1);
                     if(row4>10)
                        p_x4 = X(4) + 1*cosd(theta3(row4-10,8));
                        p_y4 = Y(4) + 1*sind(theta3(row4-10,8));
                        
                     else
                        p_x4 = X(3) + 1*cosd(theta2(row4,8));
                        p_y4 = Y(3) + 1*sind(theta2(row4,8));
                        
                     end
                  
                  elseif(m_4(1,e) == 5)
                   [Row4 Column4] = find(Distance4==min(min(Distance4(:,10))));
                   row4 = Row4(1);
                     if(row4>10)
                        p_x4 = X(5) + 1*cosd(theta3(row4-10,10));
                        p_y4 = Y(5) + 1*sind(theta3(row4-10,10));
                        
                     else
                        p_x4 = X(4) + 1*cosd(theta2(row4,10));
                        p_y4 = Y(4) + 1*sind(theta2(row4,10));
                        
                     end
                  end
             p_x(4,e) = p_x4(1);
             p_y(4,e) = p_y4(1);
          end
              
%round short-term position to target5   
          if(number5 > 1)
              for i = 1:number5
                  if(n_5(i,e) == 1)
                    [Row5 Column5] = find(Distance5==min(min(Distance5(:,4))));
                    row5(i) = Row5(1);
                     if(row5(i)>10)
                        p_x5(i) = X(5) + 1*cosd(theta3(row5(i)-10,4));
                        p_y5(i) = Y(5) + 1*sind(theta3(row5(i)-10,4));
                        distance5(i) = sqrt((p_x5(i)-x_target(5))^2+(p_y5(i)-y_target(5))^2);
                     else
                        p_x5(i) = X(1) + 1*cosd(theta2(row5(i),4));
                        p_y5(i) = Y(1) + 1*sind(theta2(row5(i),4));
                        distance5(i) = sqrt((p_x5(i)-x_target(5))^2+(p_y5(i)-y_target(5))^2);
                     end
                 
                  elseif(n_5(i,e) == 2)
                    [Row5 Column5] = find(Distance5==min(min(Distance5(:,7))));
                    row5(i) = Row5(1);
                    column5(i) = max(Column5);
                     if(row5(i)>10)
                        p_x5(i) = X(5) + 1*cosd(theta3(row5(i)-10,7));
                        p_y5(i) = Y(5) + 1*sind(theta3(row5(i)-10,7));
                        distance5(i) = sqrt((p_x5(i)-x_target(5))^2+(p_y5(i)-y_target(5))^2);
                     else
                        p_x5(i) = X(2) + 1*cosd(theta2(row5(i),7));
                        p_y5(i) = Y(2) + 1*sind(theta2(row5(i),7));
                        distance5(i) = sqrt((p_x5(i)-x_target(5))^2+(p_y5(i)-y_target(5))^2);
                     end
                  
                  elseif(n_5(i,e) == 3)
                    [Row5 Column5] = find(Distance5==min(min(Distance5(:,9))));
                    row5(i) = Row5(1);
                     if(row5(i)>10)
                        p_x5(i) = X(5) + 1*cosd(theta3(row5(i)-10,9));
                        p_y5(i) = Y(5) + 1*sind(theta3(row5(i)-10,9));
                        distance5(i) = sqrt((p_x5(i)-x_target(5))^2+(p_y5(i)-y_target(5))^2);
                     else
                        p_x5(i) = X(3) + 1*cosd(theta2(row5(i),9));
                        p_y5(i) = Y(3) + 1*sind(theta2(row5(i),9));
                        distance5(i) = sqrt((p_x5(i)-x_target(5))^2+(p_y5(i)-y_target(5))^2);
                     end
                  
                  elseif(n_5(i,e) == 4)
                    [Row5 Column5] = find(Distance5==min(min(Distance5(:,10))));
                    row5(i) = Row5(1);
                     if(row5(i)>10)
                        p_x5(i) = X(5) + 1*cosd(theta3(row5(i)-10,10));
                        p_y5(i) = Y(5) + 1*sind(theta3(row5(i)-10,10));
                        distance5(i) = sqrt((p_x5(i)-x_target(5))^2+(p_y5(i)-y_target(5))^2);
                     else
                        p_x5(i) = X(4) + 1*cosd(theta2(row5(i),10));
                        p_y5(i) = Y(4) + 1*sind(theta2(row5(i),10));
                        distance5(i) = sqrt((p_x5(i)-x_target(5))^2+(p_y5(i)-y_target(5))^2);
                     end
                  end
              end
             [w5] = find(distance5==min(distance5));
             p_x(5,e) = p_x5(w5(1));
             p_y(5,e) = p_y5(w5(1));
           else
                  if(n_5(1,e) == 1)
                    [Row5 Column5] = find(Distance5==min(min(Distance5(:,4))));
                    row5 = Row5(1);
                     if(row5>10)
                        p_x5 = X(5) + 1*cosd(theta3(row5-10,4));
                        p_y5 = Y(5) + 1*sind(theta3(row5-10,4));
                        
                     else
                        p_x5 = X(1) + 1*cosd(theta2(row5,4));
                        p_y5 = Y(1) + 1*sind(theta2(row5,4));
                        
                     end
                  
                  elseif(n_5(1,e) == 2)
                    [Row5 Column5] = find(Distance5==min(min(Distance5(:,7))));
                    row5 = Row5(1);
                     if(row5>10)
                        p_x5 = X(5) + 1*cosd(theta3(row5-10,7));
                        p_y5 = Y(5) + 1*sind(theta3(row5-10,7));
                        
                     else
                        p_x5 = X(2) + 1*cosd(theta2(row5,7));
                        p_y5 = Y(2) + 1*sind(theta2(row5,7));
                        
                     end
                  
                  elseif(n_5(1,e) == 3)
                    [Row5 Column5] = find(Distance5==min(min(Distance5(:,9))));
                    row5 = Row5(1);
                     if(row5>10)
                        p_x5 = X(5) + 1*cosd(theta3(row5-10,9));
                        p_y5 = Y(5) + 1*sind(theta3(row5-10,9));
                        
                     else
                        p_x5 = X(3) + 1*cosd(theta2(row5,9));
                        p_y5 = Y(3) + 1*sind(theta2(row5,9));
                        
                     end

                  elseif(n_5(1,e) == 4)
                    [Row5 Column5] = find(Distance5==min(min(Distance5(:,10))));
                    row5 = Row5(1);
                     if(row5>10)
                        p_x5 = X(5) + 1*cosd(theta3(row5-10,10));
                        p_y5 = Y(5) + 1*sind(theta3(row5-10,10));
                        
                     else
                        p_x5 = X(4) + 1*cosd(theta2(row5,10));
                        p_y5 = Y(4) + 1*sind(theta2(row5,10));
                  
                     end
                  end
             p_x(5,e) = p_x5(1);
             p_y(5,e) = p_y5(1);
           end
              
              for i = 1:5
                  plot(p_x(i,e),p_y(i,e),'r+','markersize',10);
                  hold on;
              end
              
              for i = 1:5
                  for u = 1:5
                     r(i,u) = sqrt((p_x(i,e)-p_x(u,e))^2+(p_y(i,e)-p_y(u,e))^2);
                  end
                     x_original(i) = X(i);
                     y_original(i) = Y(i);
                  if(r(i,:)<1)
                      X(i) = p_x(i,e);
                      Y(i) = p_y(i,e);
                  else
                      X(i) = X(i) + 0.5*(p_x(i,e)-X(i));
                      Y(i) = Y(i) + 0.5*(p_y(i,e)-Y(i));
                  end
              
              end
     
     K = 1;
     
    frame = getframe(gcf); 
    writeVideo(writerObj, frame);
    hold off
 end
    
 hold off
 close(writerObj); 