function sol=RLA(I,PSF,it)
  tic
  #Preparamos la PSF y la PSF invertida, que necesitaremos para el cálculo iterativo.
  PSF=PSF/sum(PSF(:));%Normalizamos la PSF.
  PSFinv=rot90(rot90(PSF,-1),-1);
  si=size(I);
  if ndims(I)==2; %Imágenes en grises
    Lt=zeros(si(1)+202,si(2)+202); %Añadimos 101 de borde a cada lado para evitar aartefactos.
    dim=size(Lt);
    x0=round(dim(1)/2)-(floor(si(1)/2));
    x1=round(dim(1)/2)+(floor(si(1)/2));
    y0=round(dim(2)/2)-(floor(si(2)/2));
    y1=round(dim(2)/2)+(floor(si(2)/2));
    Lt(x0+1:x1,y0+1:y1)=I(:,:);
    #Para evitar cambios bruscos, se alargará la última fila y columna de la foto con bucles for.
for i=1:x0
	Lt(i,:)=Lt(x0+1,:);
end
for i=1:y0
	Lt(:,i)=Lt(:,y0+1);
end
for i=x1:dim(1)
	Lt(i,:)=Lt(x1-1,:);
end
for i=y1:dim(2)
	Lt(:,i)=Lt(:,y1-1);
end
Lt0=Lt;
#Realizamos las iteraciones en otro bucle for
for i=1:it
	LtPSF=fftconv2(Lt,PSF,'same');
	Div=Lt0./LtPSF;
	Lt1=fftconv2(Div,PSFinv,'same').*Lt;
	err=Lt1-Lt;
	Lt=Lt1;
end
sol=Lt(x0+1:x1,y0+1:y1);
else ndims(I)== 3; %Imágenes a color.
result=zeros(si(1),si(2),3);
 Lt=zeros(si(1)+202,si(2)+202);
 dim=size(Lt);
 x0=round(dim(1)/2)-(floor(si(1)/2));
 x1=round(dim(1)/2)+(floor(si(1)/2));
 y0=round(dim(2)/2)-(floor(si(2)/2));
 y1=round(dim(2)/2)+(floor(si(2)/2));
 for c=1:3
    Lt(x0+1:x1,y0+1:y1)=I(:,:,c);
for i=1:x0
	Lt(i,:)=Lt(x0+1,:);
end
for i=1:y0
	Lt(:,i)=Lt(:,y0+1);
end
for i=x1:dim(1)
	Lt(i,:)=Lt(x1-1,:);
end
for i=y1:dim(2)
	Lt(:,i)=Lt(:,y1-1);
end
Lt0=Lt;
%Realizamos las iteraciones en otro bucle for.
for i=1:it
	LtPSF=fftconv2(Lt,PSF,'same');
	Div=Lt0./LtPSF;
	Lt1=fftconv2(Div,PSFinv,'same').*Lt;
	err=Lt1-Lt;
	Lt=Lt1;
end
corte=Lt(x0+1:x1,y0+1:y1);
result(:,:,c)=corte;
end
sol=result;
endif
toc
endfunction

