clc
clear all

sat(1)=697;
sat(2)=770;
sat(3)=852;
sat(4)=941;
sat(5)=1209;
sat(6)=1336;
sat(7)=1477;
ch=('1','2','3';'4','5','6';'7','8','9';'*','0','#');
% ch(1,1)='1';
% ch(1,2)='2';
% ch(1,3)='3';
% ch(2,1)='4';
% ch(2,2)='5';
% ch(2,3)='6';
% ch(3,1)='7';
% ch(3,2)='8';
% ch(3,3)='9';
% ch(4,1)='*';
% ch(4,2)='0';
% ch(4,3)='#';
min_id=zeros(7,2);

[tel,fs] = audioread('tel.wav');
n=7;
d = floor(length(tel)/n);
id=zeros(n,1);
for c=(1:n)
    k=(c-1)*d;
    tel1=tel(k+1:k+d);
    Y = fft(tel1);
    P2=abs(Y/d);
    t=(1:1000);
    P1 = P2(t);
    
    f = fs*(t)/d;
    max=0;
    max_second=0;
    last=0;
    for i =(1:length(P1))
        tmp=P1(i);
        if max_second < tmp
            if max < tmp
                if(abs(last-i)>5)
                    max_second=max;
                    id(c,2)=id(c,1);
                end
                max=tmp;
                id(c,1)=f(i);
                last=i;
            else
                if(abs(last-i)>5)
                    max_second=P1(i);
                    id(c,2)=f(i);
                end
            end
        end
    end
    if(id(c,1)>id(c,2))
        tmp=id(c,1);
        id(c,1)=id(c,2);
        id(c,2)=tmp;
    end
    for k=(1:2)
        mins=sat(7);
        mina=0;
        for i=(1:7)
        mina=abs(id(c,k)-sat(i));
            if(mins>mina)
                mins=mina;
                min_id(c,k)=i;
            end
        end
    end
    fprintf("%c ",ch(min_id(c,1) ,min_id(c,2)-4 ));
    figure(c);
    plot(f,P1);
    xlabel('frequency');
    ylabel('Amplitude');
    title(ch(min_id(c,1) ,min_id(c,2)-4 ));
%     subplot(2,1,2);
%     stem(f,P1);
%     xlabel('frequency');
%     ylabel('Amplitude');
end
