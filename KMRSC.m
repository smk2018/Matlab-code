clear all;
    figure;
    for j = 1:3
        x = rand(1)
        y = rand(1)
        X(j) = x;
        Y(j) = y;
        
        theta = 0:1:360;
        Circle1=X(j)+1*cosd(theta);
        Circle2=Y(j)+1*sind(theta);
        plot(Circle1,Circle2,'black','linewidth',1);
        axis equal
        hold on;
        
    end
    
    syms a b c d e f;
    r = 1;
    text(X(1),Y(1),'node1','FontSize',12);
    text(X(2),Y(2),'node2','FontSize',12);
    text(X(3),Y(3),'node3','FontSize',12);
    plot(X(1:3),Y(1:3),'+');
    %roots of each two circles
    
    [a b] = solve((a-X(1))^2+(b-Y(1))^2-r^2,(a-X(2))^2+(b-Y(2))^2-r^2);
    [c d] = solve((c-X(1))^2+(d-Y(1))^2-r^2,(c-X(3))^2+(d-Y(3))^2-r^2);
    [e f] = solve((e-X(2))^2+(f-Y(2))^2-r^2,(e-X(3))^2+(f-Y(3))^2-r^2);
    solution1 = double([a b])
    solution2 = double([c d])
    solution3 = double([e f])
    
    plot(a,b,'o');
    text(a,b,'node1 & node2','FontSize',12);
   
    plot(c,d,'go');
    text(c,d,'node1 & node3','FontSize',12);
   
    plot(e,f,'bo');
    text(e,f,'node2 & node3','FontSize',12);
   
    %degrees between each two points
    A_node1 = double(acosd(solution1(:,1)-X(1)))
    B_node1 = double(asind(solution1(:,2)-Y(1)))
    for i = 1:2
      if(B_node1(i)<0)
        if(A_node1(i) > 90)
         A_node1(i) = 360 - A_node1(i);
         B_node1(i) = 180 - B_node1(i);
        else
         A_node1(i) = 360 - A_node1(i);
         B_node1(i) = 360 + B_node1(i);
        end
      else
          if(A_node1(i)>90)
              B_node1(i) = A_node1(i);
          end      
      end      
    end
    A_node2 = double(acosd(solution1(:,1)-X(2)))  
    B_node2 = double(asind(solution1(:,2)-Y(2)))
    for i = 1:2
       if(B_node2(i)<0)
        if(A_node2(i) > 90)
         A_node2(i) = 360 - A_node2(i);
         B_node2(i) = 180 - B_node2(i);
        else
         A_node2(i) = 360 - A_node2(i);
         B_node2(i) = 360 + B_node2(i);
        end
       else
          if(A_node2(i)>90)
              B_node2(i) = A_node2(i);
          end      
      end  
    end
    C_node1 = double(acosd(solution2(:,1)-X(1)))     
    D_node1 = double(asind(solution2(:,2)-Y(1)))
    for i = 1:2
     if(D_node1(i)<0)
        if(C_node1(i) > 90)
         C_node1(i) = 360 - C_node1(i);
         D_node1(i) = 180 - D_node1(i);
        else
         C_node1(i) = 360 - C_node1(i);
         D_node1(i) = 360 + D_node1(i);
        end
     else
          if(C_node1(i)>90)
              D_node1(i) = C_node1(i);
          end      
      end  
    end
    C_node3 = double(acosd(solution2(:,1)-X(3)))    
    D_node3 = double(asind(solution2(:,2)-Y(3)))
    for i = 1:2
     if(D_node3(i)<0)
        if(C_node3(i) > 90)
         C_node3(i) = 360 - C_node3(i);
         D_node3(i) = 180 - D_node3(i);
        else
         C_node3(i) = 360 - C_node3(i);
         D_node3(i) = 360 + D_node3(i);
        end
     else
          if(C_node3(i)>90)
              D_node3(i) = C_node3(i);
          end      
      end  
    end
    E_node2 = double(acosd(solution3(:,1)-X(2)))    
    F_node2 = double(asind(solution3(:,2)-Y(2)))
   for i = 1:2
     if(F_node2(i)<0)
        if(E_node2(i) > 90)
         E_node2(i) = 360 - E_node2(i);
         F_node2(i) = 180 - F_node2(i);
        else
         E_node2(i) = 360 - E_node2(i);
         F_node2(i) = 360 + F_node2(i);
        end
     else
          if(E_node2(i)>90)
              F_node2(i) = E_node2(i);
          end      
      end  
   end
    E_node3 = double(acosd(solution3(:,1)-X(3)))
    F_node3 = double(asind(solution3(:,2)-Y(3))) 
    for i = 1:2
     if(F_node3(i)<0)
        if(E_node3(i) > 90)
         E_node3(i) = 360 - E_node3(i);
         F_node3(i) = 180 - F_node3(i);
        else
         E_node3(i) = 360 - E_node3(i);
         F_node3(i) = 360 + F_node3(i);
        end
     else
          if(E_node3(i)>90)
              F_node3(i) = E_node3(i);
          end      
      end  
    end
   
    %node1(node1&node2)
    angle = [A_node1(1) A_node1(2) B_node1(1) B_node1(2)];
    if((max(angle)-min(angle))<180)
        theta2 = min(angle):1:max(angle);
    else
        theta2 = max(angle):1:(360+min(angle));
    end
    C1=X(1)+1*cosd(theta2);
    C2=Y(1)+1*sind(theta2);%plot(C1,C2,'r+');
    plot(C1,C2,'r','linewidth',10);
    axis equal
    hold on;
   
    %node2(node1&node2)
    angle = [A_node2(1) A_node2(2) B_node2(1) B_node2(2)];
    if((max(angle)-min(angle))<180)
        theta2 = min(angle):1:max(angle);
    else
        theta2 = max(angle):1:(360+min(angle));
    end
    C1=X(2)+1*cosd(theta2);
    C2=Y(2)+1*sind(theta2);%plot(C1,C2,'r+');
    plot(C1,C2,'r','linewidth',10);
    axis equal
    hold on;
    
    %node1(node1&node3)
    angle = [C_node1(1) C_node1(2) D_node1(1) D_node1(2)];
    if((max(angle)-min(angle))<180)
        theta2 = min(angle):1:max(angle);
    else
        theta2 = max(angle):1:(360+min(angle));
    end
    C1=X(1)+1*cosd(theta2);
    C2=Y(1)+1*sind(theta2);%plot(C1,C2,'r+');
    plot(C1,C2,'r','linewidth',10);
    axis equal
    hold on;
    
    %node3(node1&node3)
    angle = [C_node3(1) C_node3(2) D_node3(1) D_node3(2)];
    if((max(angle)-min(angle))<180)
        theta2 = min(angle):1:max(angle);
    else
        theta2 = max(angle):1:(360+min(angle));
    end
    C1=X(3)+1*cosd(theta2);
    C2=Y(3)+1*sind(theta2);%plot(C1,C2,'r+');
    plot(C1,C2,'r','linewidth',10);
    axis equal
    hold on;
    
    %node3(node3&node2)
    angle = [E_node3(1) E_node3(2) F_node3(1) F_node3(2)];
    if((max(angle)-min(angle))<180)
        theta2 = min(angle):1:max(angle);
    else
        theta2 = max(angle):1:(360+min(angle));
    end
    C1=X(3)+1*cosd(theta2);
    C2=Y(3)+1*sind(theta2);%plot(C1,C2,'r+');
    plot(C1,C2,'r','linewidth',10);
    axis equal
    hold on;
    
    %node2(node3&node2)
    angle = [E_node2(1) E_node2(2) F_node2(1) F_node2(2)];
    if((max(angle)-min(angle))<180)
        theta2 = min(angle):1:max(angle);
    else
        theta2 = max(angle):1:(360+min(angle));
    end
    C1=X(2)+1*cosd(theta2);
    C2=Y(2)+1*sind(theta2);%plot(C1,C2,'r+');
    plot(C1,C2,'r','linewidth',10);
    axis equal
    hold on;
    
    
    for i = 1:3
        for j = 1:3
           weight(i,j) = 100*sqrt((X(i)-X(j))^2+(Y(i)-Y(j))^2);
        end
        total(i) = weight(i,1)+weight(i,2)+weight(i,3);
    end
    
    if total(1) <= total(2)
        if total(1) <= total(3)           
            x1 = [1,1];
            y1 = [2,3]; 
            weights = [weight(1,2),weight(1,3)];
        else
            x1 = [3,3];
            y1 = [1,2]; 
            weights = [weight(3,1),weight(3,2)];
        end
    elseif total(1) >= total(2)
        if total(2) <= total(3)
            x1 = [2,2];
            y1 = [1,3]; 
            weights = [weight(2,1),weight(2,3)];
        else
            x1 = [3,3];
            y1 = [1,2]; 
            weights = [weight(3,1),weight(3,2)];
        end
    end
   
     figure;
     G = graph(x1,y1,weights);
     p = plot(G,'EdgeLabel',G.Edges.Weight);
     [T,pred] = minspantree(G);
     highlight(p,T);
     
     %center points moving loop
     