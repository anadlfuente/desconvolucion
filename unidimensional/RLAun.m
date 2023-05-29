%unidimensional RLA
function imag=RLAun(v,PSF,it)
  #Preparamos la PSF y la PSF invertida, que necesitaremos para el cálculo iterativo.
  PSF=PSF/sum(PSF);
  PSFinv=PSF(end:-1:1);
  #Aplicamos el algoritmo RLA
  v0=v;
for i=1:it
	LtPSF=conv(v,PSF,'same');
	Div=v0./LtPSF;
	v1=conv(Div,PSFinv,'same').*v;
	v=v1;
end
imag=v;
endfunction
