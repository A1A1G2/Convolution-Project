[tel,fs] = audioread('tel.wav');
n=7;
d = floor(length(tel)/n);
ch=['1' '2' '3';'4' '5' '6';'7' '8' '9';'*' '0' '#'];
degerler=[697,770,852,941,1209,1336,1477];
c=zeros(2,1);
for j=(1:n)
    tel1 = tel(((j-1)*d)+1:j*d);
    y = fft(tel1);
    F1=abs(y/d);
    F2=F1(1:d/2);
    f = fs*(1:(d/2))/d;
    figure(j);
    plot(f,F2);
    k=1;
    l=1;
    ctr=0;
    while(ctr<2)
        for i =(1:length(F2))
            if(F2(i)>k && F2(i+1)<k)
                ctr=ctr+1;
            end
        end
        k=k-0.01;
    end
    for i =(1:length(F2))
        if(F2(i)>k && F2(i+1)<k)
            c(l)=f(i);
            l=l+1;
        end
    end
    %fprintf("%d %d \n",c(1) ,c(2));
    minimum=degerler(length(degerler));
    for ctr=(1:length(degerler))
        fark=abs(degerler(ctr)-c(1));
        if(minimum>fark)
            minknm(1)=ctr;
            minimum=fark;
        end
    end
    minimum=degerler(length(degerler));
    for ctr=(1:length(degerler))
        fark=abs(degerler(ctr)-c(2));
        if(minimum>fark)
            minknm(2)=ctr;
            minimum=fark;
        end
    end
    fprintf("%c \n",ch(minknm(1) ,minknm(2)-4 ));
   
 
end

