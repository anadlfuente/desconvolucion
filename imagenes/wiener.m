function sol=wiener(A,B,alfa);
  tic
  %Calculamos las dimensiones de la imagen y la psf
  sb=size(B);
  sa=size(A);
  %Para evitar artefactos en los bordes alargamos ambas imágenes añadiendo 101 a cada lado.
  PSF=zeros(sa(1)+202,sa(2)+202);
  dim=size(PSF);
  PSF(round(dim(1)/2)-floor(sb(1)/2)+1:round(dim(1)/2)+round(sb(1)/2),round(dim(2)/2)-floor(sb(2)/2)+1:round(dim(2)/2)+round(sb(2)/2))=B;
  PSF= PSF/sum(PSF(:)); %Normalizamos la PSF.
  %calculamos el filtrado de wiener(w).
  ptc=fftshift(fft2(PSF));
  a=alfa;
  w=conj(ptc)./(abs(ptc).^2.+a); %Utilizamos la forma optimizada para el cálculo. Además evitamos 0 en el coeficiente.
  %Diferenciamos el tratamiento para imágenes a color y en grises.
  if (ndims(A))==2; %Imágenes en grises
    %Alargamos la imagen con el mismo tamaño que la psf previamente calculada.
    s=zeros(sa(1)+202,sa(2)+202);
    dims=size(s);
    %Calculamos los valores de los bordes de la imagen
    x0=round(dims(1)/2)-(floor(sa(1)/2));
    x1=round(dims(1)/2)+(floor(sa(1)/2));
    y0=round(dims(2)/2)-(floor(sa(2)/2));
    y1=round(dims(2)/2)+(floor(sa(2)/2));
    s(x0+1:x1,y0+1:y1)=A(:,:);%Añadimos a la matriz s la imagen.
    %Realizamos los bucles for para alargar los bordes de la imagen.
for i=1:x0
  s(i,:)=s(x0+1,:);
end
for i=1:y0
	s(:,i)=s(:,y0+1);
end
for i=x1:dims(1);
	s(i,:)=s(x1-1,:);
end
for i=y1:dims(2);
	s(:,i)=s(:,y1-1);
end
 %Procedemos a trabajar en el espacio de Fourier
 stc=fftshift(fft2(s));
 Imtc=stc.*w;
 Im=fftshift(ifft2(fftshift(Imtc)));
 Imr=real(Im);
 sol=Imr(x0+1:x1,y0+1:y1);
else ndims(A)==3;
 result=zeros(sa(1),sa(2),3);
 %Alargamos la imagen con el mismo tamaño que la psf previamente calculada.
    s=zeros(sa(1)+202,sa(2)+202);
    dims=size(s);
    %Calculamos los valores de los bordes de la imagen
    x0=round(dims(1)/2)-(floor(sa(1)/2));
    x1=round(dims(1)/2)+(floor(sa(1)/2));
    y0=round(dims(2)/2)-(floor(sa(2)/2));
    y1=round(dims(2)/2)+(floor(sa(2)/2));
    for c=1:3
    s(x0+1:x1,y0+1:y1)=A(:,:,c);%Añadimos a la matriz s la imagen.
    %Realizamos los bucles for para alargar los bordes de la imagen.
for i=1:x0
  s(i,:)=s(x0+1,:);
end
for i=1:y0
	s(:,i)=s(:,y0+1);
end
for i=x1:dims(1);
	s(i,:)=s(x1-1,:);
end
for i=y1:dims(2);
	s(:,i)=s(:,y1-1);
end
 %Procedemos a trabajar en el espacio de Fourier
 stc=fftshift(fft2(s));
 Imtc=stc.*w;;
 Im=fftshift(ifft2(fftshift(Imtc)));
 Imr=real(Im);
 corte=Imr(x0+1:x1,y0+1:y1);
 result(:,:,c)=corte;
end
sol=result;
toc
  endif
endfunction
