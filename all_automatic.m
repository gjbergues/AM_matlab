%hace todo el procedimienot dependiendo si es horario o antihorario
%horario=0;
%antihorio=1;

%Method
%HOUGH=0
%GAUSS=1
%REGRES=2
%MAX = 3
%PROB =4
%rgb = 5

%function [medh, posh, medv, posv]=all_automatic(h,M) %when
%I need to see some value 
function  [pHv, medh_RGB] = all_automatic(h,M)
%     clear all
%     close all

    ND = 51;
    
    %Initial values to acelerate process
    pHv = zeros(1, 51);
    medh_H = zeros(1,51);
    BVV2 = zeros(1,51);
    BHH2 = zeros(1,51);
    IV2 = zeros(51,5);
    IH2 = zeros(51,5);
    medh = zeros(1,51);
    medv = zeros(1,51);
    
    for k = 1:ND % numero de directorios
        
        if (M==0)%HOUGH
            [pos_hough] = Hough_function(k,h);
            pHv(k) = pos_hough; %is just the horizontal position
        end
    
        if (M==1)%GAUSS
           [BVV, BHH, IV, IH] = analisis_cruz_for_automatic(k,h);
 
            BVV2(k) = BVV;
            BHH2(k) = BHH;
            IV2(k,:) = IV;
            IH2(k,:) = IH;
        end
        
        if (M==2)%REGRES
            [pos_reg] = reg_function(k,h);
            pHv(k) = pos_reg; %is just the horizontal position
        end
                 
        if (M==3)%MAX
            [pos_max] = max_function(k,h);
            pHv(k) = pos_max; %is just the horizontal position
        end

         if (M==4)%PROB
            [pos_prob] = prob_function(k,h);
            pHv(k) = pos_prob; %is just the horizontal position
        end
        
         if (M==5)%RGB
            [pos_rgb] = cruz_rgb(k,h);
            pHv(k) = pos_rgb; %is just the horizontal position
        end
    end
 
    if (M==0)%HOUGH
        %Measurement Results
    
        %%%%Cross Horizontal positions%%%%%%
            
        for i = 1:ND
            medh_H(i) = (-(pHv(i)-pHv(1)))*60/97.3;   
        end    

   
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%ESCRITURA EN EXCEL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %ANTIHORARIO
        if (h==1)
            nah=xlsread('nivel.xlsx','B3:B53');%med nivel antihorario
            nahref= (nah - nah(1)); %referencio el nivel a la primera medición
            xlswrite('nivel.xlsx', nahref, 1,'F3:F53');%escribo en tabla
            xlswrite('nivel.xlsx', medh_H', 1,'G3:G53');%coloco medición con interfaz HOUGH
            difah_H = nahref + medh_H';%hago la diferencia entre nivel-autocolimador
            xlswrite('nivel.xlsx', difah_H, 1,'H3:H53');%escribo diferencia
            %xlswrite('nivel.xlsx',medv',1,'F3:F53');%valores verticales
        end
 
        %%HORARIO%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if (h==0)
            nh = xlsread('nivel.xlsx','I3:I53');%med nivel horario
            nhref = nh - nh(1);
            xlswrite('nivel.xlsx', nhref, 1,'P3:P53');
            xlswrite('nivel.xlsx', medh_H', 1,'Q3:Q53');%coloco medición con interfaz
            difh_H = nhref + medh_H';%hago la diferencia entre nivel-autocolimador
            xlswrite('nivel.xlsx', difh_H, 1,'R3:R53');%escribo diferencia
            %xlswrite('nivel.xlsx',medv',1,'M3:M53');%valores verticales
        end
 
    end

    if (M==1)%GAUSS
        %Measurement Results
    
        %%%%Cross Horizontal positions%%%%%%
        posh = BHH2;
       
    
        for i = 1:ND
            medh(i) = (-(BHH2(i)-BHH2(1)))*60/97.3;                
        end    

   
        %%%%Cross Vertical positions%%%%%%
        posv = BVV2;
        for j = 1:ND
            medv(j) = (-(BVV2(j)-BVV2(1)))*60/97.3;        
        end
 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%ESCRITURA EN EXCEL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %ANTIHORARIO
        if (h==1)
            nah=xlsread('nivel.xlsx','B3:B53');%med nivel antihorario
            nahref= (nah - nah(1));%referencio el nivel a la primera medición
            xlswrite('nivel.xlsx', nahref, 1,'C3:C53');%escribo en tabla
            xlswrite('nivel.xlsx', medh', 1,'D3:D53');%coloco medición con interfaz
            difah = nahref + medh';%hago la diferencia entre nivel-autocolimador
            xlswrite('nivel.xlsx', difah, 1,'E3:E53');%escribo diferencia
            xlswrite('nivel.xlsx', medv' , 1,'I3:I53');%valores verticales
        end
 
        %%HORARIO%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if (h==0)
            nh = xlsread('nivel.xlsx','L3:L53');%med nivel horario
            nhref = nh - nh(1);
            xlswrite('nivel.xlsx',nhref,1,'M3:M53');
            xlswrite('nivel.xlsx',medh',1,'N3:N53');%coloco medición con interfaz
            difh = nhref+medh';%hago la diferencia entre nivel-autocolimador
            xlswrite('nivel.xlsx',difh,1,'O3:O53');%escribo diferencia
            xlswrite('nivel.xlsx',medv',1,'S3:S53');%valores verticales
        end
 
    end
    if (M==2)%REGRESION
        %Measurement Results
    
        %%%%Cross Horizontal positions%%%%%%
            
        for i = 1:ND
            medh_R(i) = (-(pHv(i)-pHv(1)))*60/97.3;   
        end    

   
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%ESCRITURA EN EXCEL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %ANTIHORARIO
        if (h==1)
            nah=xlsread('nivel_gaussyregres.xlsx','B3:B53');%med nivel antihorario
            nahref= (nah - nah(1)); %referencio el nivel a la primera medición
            xlswrite('nivel_gaussyregres.xlsx', nahref, 1,'F3:F53');%escribo en tabla
            xlswrite('nivel_gaussyregres.xlsx', medh_R', 1,'G3:G53');%coloco medición con interfaz HOUGH
            difah_R = nahref + medh_R';%hago la diferencia entre nivel-autocolimador
            xlswrite('nivel_gaussyregres.xlsx', difah_R, 1,'H3:H53');%escribo diferencia
            %xlswrite('nivel.xlsx',medv',1,'F3:F53');%valores verticales
        end
 
        %%HORARIO%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if (h==0)
            nh = xlsread('nivel_gaussyregres.xlsx','I3:I53');%med nivel horario
            nhref = nh - nh(1);
            xlswrite('nivel_gaussyregres.xlsx', nhref, 1,'P3:P53');
            xlswrite('nivel_gaussyregres.xlsx', medh_R', 1,'Q3:Q53');%coloco medición con interfaz
            difh_R = nhref + medh_R';%hago la diferencia entre nivel-autocolimador
            xlswrite('nivel_gaussyregres.xlsx', difh_R, 1,'R3:R53');%escribo diferencia
            %xlswrite('nivel.xlsx',medv',1,'M3:M53');%valores verticales
        end
 
    end

    
    if (M==3)%MAX
        %Measurement Results
    
        %%%%Cross Horizontal positions%%%%%%
            
        for i = 1:ND
            medh_M(i) = (-(pHv(i)-pHv(1)))*60/97.3;   
        end    

   
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%ESCRITURA EN EXCEL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %ANTIHORARIO
        if (h==1)
            nah=xlsread('nivel_gaussymax.xlsx','B3:B53');%med nivel antihorario
            nahref= (nah - nah(1)); %referencio el nivel a la primera medición
            xlswrite('nivel_gaussymax.xlsx', nahref, 1,'F3:F53');%escribo en tabla
            xlswrite('nivel_gaussymax.xlsx', medh_M', 1,'G3:G53');%coloco medición con interfaz HOUGH
            difah_M = nahref + medh_M';%hago la diferencia entre nivel-autocolimador
            xlswrite('nivel_gaussymax.xlsx', difah_M, 1,'H3:H53');%escribo diferencia
            %xlswrite('nivel.xlsx',medv',1,'F3:F53');%valores verticales
        end
 
        %%HORARIO%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if (h==0)
            nh = xlsread('nivel_gaussymax.xlsx','I3:I53');%med nivel horario
            nhref = nh - nh(1);
            xlswrite('nivel_gaussymax.xlsx', nhref, 1,'P3:P53');
            xlswrite('nivel_gaussymax.xlsx', medh_M', 1,'Q3:Q53');%coloco medición con interfaz
            difh_M = nhref + medh_M';%hago la diferencia entre nivel-autocolimador
            xlswrite('nivel_gaussymax.xlsx', difh_M, 1,'R3:R53');%escribo diferencia
            %xlswrite('nivel.xlsx',medv',1,'M3:M53');%valores verticales
        end
 
    end

    
    
    if (M==4)%PROB
        %Measurement Results
    
        %%%%Cross Horizontal positions%%%%%%
            
        for i = 1:ND
            medh_P(i) = (-(pHv(i)-pHv(1)))*60/97.3;   
        end    

   
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%ESCRITURA EN EXCEL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %ANTIHORARIO
        if (h==1)
            nah=xlsread('nivel_gaussyprob.xlsx','B3:B53');%med nivel antihorario
            nahref= (nah - nah(1)); %referencio el nivel a la primera medición
            xlswrite('nivel_gaussyprob.xlsx', nahref, 1,'F3:F53');%escribo en tabla
            xlswrite('nivel_gaussyprob.xlsx', medh_P', 1,'G3:G53');%coloco medición con interfaz HOUGH
            difah_P = nahref + medh_P';%hago la diferencia entre nivel-autocolimador
            xlswrite('nivel_gaussyprob.xlsx', difah_P, 1,'H3:H53');%escribo diferencia
            %xlswrite('nivel.xlsx',medv',1,'F3:F53');%valores verticales
        end
 
        %%HORARIO%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if (h==0)
            nh = xlsread('nivel_gaussyprob.xlsx','I3:I53');%med nivel horario
            nhref = nh - nh(1);
            xlswrite('nivel_gaussyprob.xlsx', nhref, 1,'P3:P53');
            xlswrite('nivel_gaussyprob.xlsx', medh_P', 1,'Q3:Q53');%coloco medición con interfaz
            difh_P = nhref + medh_P';%hago la diferencia entre nivel-autocolimador
            xlswrite('nivel_gaussyprob.xlsx', difh_P, 1,'R3:R53');%escribo diferencia
            %xlswrite('nivel.xlsx',medv',1,'M3:M53');%valores verticales
        end
 
    end
    
    if (M==5)%RGB
        %Measurement Results
    
        %%%%Cross Horizontal positions%%%%%%
            
        for i = 1:ND
            medh_RGB(i) = (-(pHv(i)-pHv(1)))*60/97.3;   
        end    

   
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%ESCRITURA EN EXCEL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %ANTIHORARIO
        if (h==1)
            nah=xlsread('nivel_gaussyrgb.xlsx','B3:B53');%med nivel antihorario
            nahref= (nah - nah(1)); %referencio el nivel a la primera medición
            xlswrite('nivel_gaussyrgb.xlsx', nahref, 1,'F3:F53');%escribo en tabla
            xlswrite('nivel_gaussyrgb.xlsx', medh_RGB', 1,'G3:G53');%coloco medición con interfaz HOUGH
            difah_rgb = nahref + medh_RGB';%hago la diferencia entre nivel-autocolimador
            xlswrite('nivel_gaussyrgb.xlsx', difah_rgb, 1,'H3:H53');%escribo diferencia
            %xlswrite('nivel.xlsx',medv',1,'F3:F53');%valores verticales
        end
 
        %%HORARIO%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if (h==0)
            nh = xlsread('nivel_gaussyrgb.xlsx','I3:I53');%med nivel horario
            nhref = nh - nh(1);
            xlswrite('nivel_gaussyrgb.xlsx', nhref, 1,'P3:P53');
            xlswrite('nivel_gaussyrgb.xlsx', medh_RGB', 1,'Q3:Q53');%coloco medición con interfaz
            difh_rgb = nhref + medh_RGB';%hago la diferencia entre nivel-autocolimador
            xlswrite('nivel_gaussyrgb.xlsx', difh_rgb, 1,'R3:R53');%escribo diferencia
            %xlswrite('nivel.xlsx',medv',1,'M3:M53');%valores verticales
        end
 
    end
    
end%FINAL FUNCIÓN