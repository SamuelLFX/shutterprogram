%% Instrument Connection

% Find a VISA-USB object.
obj1 = instrfind('Type', 'visa-usb', 'RsrcName', 'USB0::0x1AB1::0x04CE::DS1ZA210700956::0::INSTR', 'Tag', '');

% Create the VISA-USB object if it does not exist
% otherwise use the object that was found.
if isempty(obj1)
    obj1 = visa('NI', 'USB0::0x1AB1::0x04CE::DS1ZA210700956::0::INSTR');
else
    fclose(obj1);
    obj1 = obj1(1);
end

% Configure instrument object, obj1

set(obj1, 'InputBufferSize', 300000);

% Configure instrument object, obj1

set(obj1, 'OutputBufferSize', 512);

%% Disconnect and Clean Up

% Disconnect from instrument object, obj1.
fclose(obj1);

%% Instrument Connection

% Connect to instrument object, obj1.
fopen(obj1);

%% Instrument Configuration and Control

% Communicating with instrument object, obj1.
loop=1;
threshold1=5000;
threshold2=5000;
threshold3=9000;
totledgnum=0;
totledgnum2=0;
slopenumber=0;
mark1=zeros(1,1);
mark2=zeros(1,1);
mark3=zeros(1,1);
F(loop)=struct('cdata',[],'colormap',[]);
for j=1:loop
edgenumber=0;
fprintf(obj1, ' :STOP');
fprintf(obj1, ' :WAV:SOUR CHAN2');
fprintf(obj1, ' :WAV:MODE RAW');
fprintf(obj1, ' :WAV:FORM BYTE');
fprintf(obj1, ':WAV:STAR 1 ');
fprintf(obj1, ' :WAV:STOP 250000');
fprintf(obj1, ' :WAV:DATA?');
data1 = binblockread(obj1, 'int16');

fprintf(obj1, ':WAV:STAR 250001 ');
fprintf(obj1, ' :WAV:STOP 500000');
fprintf(obj1, ' :WAV:DATA?');
data2 = binblockread(obj1, 'int16');


fprintf(obj1, ' :WAV:SOUR CHAN1');
fprintf(obj1, ' :WAV:MODE RAW');
fprintf(obj1, ' :WAV:FORM BYTE');
fprintf(obj1, ':WAV:STAR 1 ');
fprintf(obj1, ' :WAV:STOP 250000');
fprintf(obj1, ' :WAV:DATA?');
data3 = binblockread(obj1, 'int16');

fprintf(obj1, ':WAV:STAR 250001 ');
fprintf(obj1, ' :WAV:STOP 500000');
fprintf(obj1, ' :WAV:DATA?');
data4 = binblockread(obj1, 'int16');
fprintf(obj1, ' :RUN');
datag=[data1' data2'];
datah=[data3' data4'];
%%
% i=79000;
% while 1
%     
%         if datah(i)>threshold1
%             if datah(i+1)>threshold1 && datah(i+2)>threshold1
%                 totledgnum=totledgnum+1; mark1(totledgnum,1)=i;
%                 break
%             end
%         end
%         i=i+1;
% end       
%     
% ib=89000;
% while 1
%     
%         if datah(ib)<threshold3
%             if datah(ib+1)<threshold3 && datah(ib+2)<threshold3
%                 slopenumber=slopenumber+1; mark3(slopenumber,1)=ib;
%                 break
%             end
%         end
%         ib=ib-1;
% end      
% %     cut=datah(85000+i*500+1:85000+(i+1)*500);
% %     m=mean(cut);
% %     if m>3800 && m<5500
% %         for k=1:500
% %             if cut(k)>3600 && cut(k)<4500
% %                 totledgnum=totledgnum+1; mark1(totledgnum)=85000+i*500+k;
% %             break
% %             end
% %         end
% %     end 
% 
% kb=176000;
% while 1
%     
%         if datah(kb)<threshold3
%             if datah(kb+1)<threshold3 && datah(kb+2)<threshold3
%                 slopenumber=slopenumber+1; mark3(slopenumber,1)=kb;
%                 break
%             end
%         end
%         kb=kb+1;
% end      
% 
% k=190000;
% while 1
%   if datah(k)>threshold2
%             if datah(k-1)>threshold1 && datah(k-2)>threshold1
%                 totledgnum=totledgnum+1; mark1(totledgnum,1)=k;
%                 break
%             end
%   end
%   k=k-1;
% end
% %     cut=datah(190000-i*500:190000-(i+1)*500+1);
% %     m=mean(cut);
% %     if m>3800 && m<4200
% %         for k=1:500
% %             if cut(k)>3600 && cut(k)<4000
% %                 totledgnum=totledgnum+1; mark1(totledgnum)=85000+i*500+k;
% %             break
% %             end
% %         end
% %     end 
% 
% i2=70000;
% while 1
%     
%         if datag(i2)>4200
%             if datag(i2+1)>threshold2 && datag(i2+2)>threshold2
%                 totledgnum2=totledgnum2+1; mark2(totledgnum2,1)=i2;
%                 break
%             end
%         end
%         i2=i2+1;
% end
% 
% k2=175000;
% while 1
%   if datag(k2)>4200
%             if datag(k2-1)>threshold2 && datag(k2-2)>threshold2
%                 totledgnum2=totledgnum2+1; mark2(totledgnum2,1)=k2;
%                 break
%             end
%   end
%   k2=k2-1;
%      
% end
% %     cut=datah(190000-i*500:190000-(i+1)*500+1);
% %     m=mean(cut);
% %     if m>3800 && m<4200
% %         for k=1:500
% %             if cut(k)>3600 && cut(k)<4000
% %                 totledgnum=totledgnum+1; mark1(totledgnum)=85000+i*500+k;
% %             break
% %             end
% %         end
% %     end 
% 
%  
% %% Making Movies
 t=1:length(datag);
% axis([0 250000 0 20000]);
% h=gca;
% hold on
% h.YLimMode='manual';
% plot(t,datag)
% hold on
% plot(t,datah)
% drawnow
% F(j)=getframe;
% pause(0.5)
% close
% pause(17)
%  end
% % %% 
% delay= (1/5000)*(mark1-mark2);  
% switchingtime=(1/5000)*abs(mark3-mark1);
% sz=10;
% size=1:totledgnum/2;
% activationdelay=zeros(1,1);
% pulseshape=zeros(1,1);
% switching=zeros(1,1);
% for v=1:totledgnum/2
%     switching(v)=switchingtime(2*v-1);
% end
% for g=1:totledgnum/2
% activationdelay(g)=delay(2*g-1);
% end
% for w=1:totledgnum/2
%     pulseshape(w,1)=(mark1(2*w)-mark1(2*w-1))/(mark2(2*w)-mark2(2*w-1));
% end
% figure(1)
% row=1:totledgnum;
% scatter(size, pulseshape,sz,'filled')
% figure(2)
% scatter(size,activationdelay,sz,'filled')
% figure(3)
% scatter(size,switching,sz,'filled')
end
%% Inspection
figure(4)
axis([0 250000 0 20000]);
h=gca;
hold on
h.YLimMode='manual';
plot(t,datag)
hold on
plot(t,datah)
%movie(F,1,5)
%imshow(F(405).cdata)