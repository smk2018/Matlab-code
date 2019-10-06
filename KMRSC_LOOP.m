clear all;
    for i = 1:5
      x_target(i) = randi(3)*randi(3);%randsrc(1)*randi(3);
      y_target(i) = randi(3)*randi(3);%randsrc(1)*randi(3);
      x = rand(1)
      y = rand(1)
      X(i) = x;
      Y(i) = y;
    end
    
  K = 1;
  
  %fid = figure;
  %hold on
  %writerObj = VideoWriter('out.avi'); 
  %writerObj.FrameRate = 2; 
  %open(writerObj); 

  
  %for e = 1:2
  %while(abs(X(1)-x_target(1))>0.0005||abs(Y(1)-y_target(1))>0.0005)
       %pause(0.1);
       %figure(fid);
       
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
         plot(root_x1(i,j),root_y1(i,j),'o');
         plot(root_x2(i,j),root_y2(i,j),'o');
         
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
                   %theta2 = min(angle1):lin1:max(angle1);
              else
                   theta2(:,K) = linspace(max(angle1),360+min(angle1),10);
                   %theta2 = max(angle1):lin1:(360+min(angle1));
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
                 plot(C1,C2,'b+');
                 %plot(C1,C2,'r','linewidth',10);
                 axis equal
                 hold on;
              
              angle2 = [x3_angle(i,j) x4_angle(i,j) y3_angle(i,j) y4_angle(i,j)];
              if((max(angle2)-min(angle2))<180)
                  theta3(:,K) = linspace(min(angle2)+5,max(angle2)-5,10);
                   %theta3 = min(angle2):lin2:max(angle2);
              else
                  theta3(:,K) = linspace(max(angle2)+5,360+min(angle2)-5,10);
                   %theta3 = max(angle2):lin2:(360+min(angle2));
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
                 plot(C3,C4,'b+');
                 %plot(C3,C4,'r','linewidth',10);
                 axis equal
                 hold on;    
                 
              
              distance1(i,j) = min(Distance1(:,K));
              distance2(i,j) = min(Distance2(:,K));
              distance3(i,j) = min(Distance3(:,K));
              distance4(i,j) = min(Distance4(:,K));
              distance5(i,j) = min(Distance5(:,K));
              K = K + 1;
       end
        
      end
    end
              [row1 column1] = find(Distance1==min(min(Distance1)));
              [row2 column2] = find(Distance2==min(min(Distance2)));
              [row3 column3] = find(Distance3==min(min(Distance3)));
              [row4 column4] = find(Distance4==min(min(Distance4)));
              [row5 column5] = find(Distance5==min(min(Distance5)));
              row(1) = max(row1);
              column(1) = max(column1);
              row(2) = max(row2);
              column(2) = max(column2);
              row(3) = max(row3);
              column(3) = max(column3);
              row(4) = max(row4);
              column(4) = max(column4);
              row(5) = max(row5);
              column(5) = max(column5);
              
              distance1(distance1==0)=inf;
              [ii1 jj1] = find(distance1==min(min(distance1)));
              ii(1) = max(ii1);
              jj(1) = max(jj1);
              distance2(distance2==0)=inf;
              [ii2 jj2] = find(distance2==min(min(distance2)));
              ii(2) = max(ii2);
              jj(2) = max(jj2);
              distance3(distance3==0)=inf;
              [ii3 jj3] = find(distance3==min(min(distance3)));
              ii(3) = max(ii3);
              jj(3) = max(jj3);
              distance4(distance4==0)=inf;
              [ii4 jj4] = find(distance4==min(min(distance4)));
              ii(4) = max(ii4);
              jj(4) = max(jj4);
              distance5(distance5==0)=inf;
              [ii5 jj5] = find(distance5==min(min(distance5)));
              ii(5) = max(ii5);
              jj(5) = max(jj5);
              
              for i = 1:5
                  if(row(i)>10)
                      p_x(i) = X(jj(i)) + 1*cosd(theta3(row(i)-10,column(i)));
                      p_y(i) = Y(jj(i)) + 1*sind(theta3(row(i)-10,column(i)));
                  else
                      p_x(i) = X(ii(i)) + 1*cosd(theta2(row(i),column(i)));
                      p_y(i) = Y(ii(i)) + 1*sind(theta2(row(i),column(i)));
                  end
                  plot(p_x(i),p_y(i),'r+','markersize',10);
                  hold on;
                  
              end
              
              for i = 1:5
                  for u = 1:5
                  r(i,u) = sqrt((p_x(i)-p_x(u))^2+(p_y(i)-p_y(u))^2);
                  end
                  x_original(i) = X(i);
                  y_original(i) = Y(i);
                  if(r(i,:)<1)
                      X(i) = p_x(i);
                      Y(i) = p_y(i);
                  else
                      X(i) = X(i) + 0.5*(p_x(i)-X(i));
                      Y(i) = Y(i) + 0.5*(p_y(i)-Y(i));
                  end
              
              end
    
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

    %x1 = [L(1),L(1)];
    %y1 = [L(2),L(3)];
    %weights = [weight(L(1),L(2)),weight(L(1),L(3))];
    
    
     figure;
     G = graph(x1,y1,weights);
     p = plot(G,'EdgeLabel',G.Edges.Weight);
     [T,pred] = minspantree(G);
     highlight(p,T);
    
     
     for i = 2:5
       if(pred(i)>i)
         n(i-1) = i;
         m(i-1) = pred(i);
       else
         n(i-1) = pred(i);
         m(i-1) = i;
       end
     end
     
     number1 = 1;
     number2 = 1;
     number3 = 1;
     number4 = 1;
     number5 = 1;
     for j = 1:4
 
         if(n(j) == 1)
             n_i1(number1) = n(j);
             m_j1(number1) = m(j);
             number1 = number1 + 1;
         end
         
         if(n(j) == 2)
             n_i2(number2) = n(j);
             m_j2(number2) = m(j);
             number2 = number2 + 1;
         end
         if(m(j) == 2)
             n_i2(number2) = m(j);
             m_j2(number2) = n(j);
             number2 = number2 + 1;
         end
        
         if(n(j) == 3)
             n_i3(number3) = n(j);
             m_j3(number3) = m(j);
             number3 = number3 + 1;
         end
         if(m(j) == 3)
             n_i3(number3) = m(j);
             m_j3(number3) = n(j);
             number3 = number3 + 1;
         end
         
         if(n(j) == 4)
             n_i4(number4) = n(j);
             m_j4(number4) = m(j);
             number4 = number4 + 1;
         end
         if(m(j) == 4)
             n_i4(number4) = m(j);
             m_j4(number4) = n(j);
             number4 = number4 + 1;
         end
         
         if(n(j) == 5)
             n_i5(number5) = n(j);
             m_j5(number5) = m(j);
             number5 = number5 + 1;
         end
         if(m(j) == 5)
             n_i5(number5) = m(j);
             m_j5(number5) = n(j);
             number5 = number5 + 1;
         end
   
     end
     
     
     K = 1;
    % frame = getframe(gcf); 
    % writeVideo(writerObj, frame);
     %hold off
  %end
    
 %hold off
 %close(writerObj); 