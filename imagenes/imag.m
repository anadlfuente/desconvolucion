function imag(imagen,imagenpsf,alpha,it);  %donde 'imagen' es la imagen borrada; 'imagenpsf', la PSF a aplicar;'alpha' el número alfa;'it' el número de iteraciones para RLA.
  %Cargamos las matrices de las imágenes.
  I=im2double(imread(imagen));
  psf=im2double(imread(imagenpsf));
  %Aplicamos las funciones previamente realizadas para cada tratamiento
  wien=normal(wiener(I,psf,alpha));
  rla=normal(RLA(I,psf,it)); %utilizamos la funcion 'normal' para normalizar los resultados del tratamiento.
  %creamos una imagen compuesta de la imagen borrosa, la psf y lass soluciones con ambos algoritmos.
  subplot(2,2,1); imshow(I); title('original');
  subplot(2,2,2);imshow(psf);title('psf');
  subplot(2,2,3);imshow(rla);title('RLA');
  subplot(2,2,4);imshow(wien);title('wiener');
  endfunction


