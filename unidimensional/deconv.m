function deconv(vect,vectpsf,alfa,it); %Donde 'vect' es la se�al contaminada;'vectpsf' la PSF;'alfa' el n�mero alfa;'it' el n�mero de iteraciones para RLA.
  %Cargamos ambas se�ales
  v=load(vect);
  psf=load(vectpsf);
  %Aplicamos los dos procesamientos a la se�al.
  wien=wienerun(v,psf,alfa);
  rla=RLAun(v,psf,it);
  %Creamos una gr�fica donde se a�ada la se�al contaminada, la PSF y los resultados de los dos algoritmos.
  subplot(2,2,1);plot(v);title('original');
  subplot(2,2,2);plot(psf);title('psf');
  subplot(2,2,4);plot(wien);hold on; plot(v);hold off;title('original+wiener');
  subplot(2,2,3);plot(rla);hold on; plot(v);hold off;title('original+RLA');
endfunction

