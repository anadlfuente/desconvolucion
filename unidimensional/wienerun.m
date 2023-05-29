function spectrumf=wienerun(spectrum,psfo,alfa)
  %Centramos la psf en un nuevo vector con la misma longitud que el vector contaminado.
  sizesp=rows(spectrum);
  sizepsf=rows(psfo);
  psfo=psfo./sum(psfo);
  psf=zeros(sizesp);
  [A,B]=max(psfo);
  psf(round(sizesp/2-B)+1:round(sizesp/2+(sizepsf-B)))=psfo;
  %Aplicamos el filtrado en el espacio de fourier.
  ptc=fftshift(fft(psf));
  a=alfa;
  w=(abs(ptc).^2)./(abs(ptc).^2.+a);
  spectrumtc=fftshift(fft(spectrum));
  spectrumftc=spectrumtc.*w./ptc;
  spectrumf=real(fftshift(ifft(fftshift(spectrumftc))));
endfunction
