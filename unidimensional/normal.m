function sol=normal(imagen);
  mx=max(imagen(:));
  mn=min(imagen(:));
  sol=(imagen-mn)/(mx-mn);
  endfunction
