
function [K,K2] = BuildKernels(Hx,Hy,Hx2,Hy2,ker,p1,method)

switch lower(method)

	case {'svr'}
    K = kernelmatrix(ker,[Hx;Hy],[Hx;Hy],p1.z);
    K2 = kernelmatrix(ker,[Hx;Hy],[Hx2;Hy2],p1.z);
    	
	case {'2k'} % 2K
    K = kernelmatrix(ker,Hx,Hx,p1.x)+kernelmatrix(ker,Hy,Hy,p1.y);
    K2 = kernelmatrix(ker,Hx,Hx2,p1.x)+kernelmatrix(ker,Hy,Hy2,p1.y);
	
	case {'svr+2k'}	% 2K + SVR
    K = kernelmatrix(ker,Hx,Hx,p1.x)+kernelmatrix(ker,Hy,Hy,p1.y)+kernelmatrix(ker,[Hx;Hy],[Hx;Hy],p1.z);
    K2 = kernelmatrix(ker,Hx,Hx2,p1.x)+kernelmatrix(ker,Hy,Hy2,p1.y)+kernelmatrix(ker,[Hx;Hy],[Hx2;Hy2],p1.z);
	
	case {'4k'}		% 4K
    K = kernelmatrix(ker,Hx,Hx,p1.x)+kernelmatrix(ker,Hy,Hy,p1.y)+kernelmatrix(ker,Hx,Hy,p1.xy)+kernelmatrix(ker,Hy,Hx,p1.xy);
    K2 = kernelmatrix(ker,Hx,Hx2,p1.x)+kernelmatrix(ker,Hy,Hy2,p1.y)+kernelmatrix(ker,Hx,Hy2,p1.xy)+kernelmatrix(ker,Hy,Hx2,p1.xy);
	
	case {'svr+4k'}	% 4K + SVR
    K = kernelmatrix(ker,Hx,Hx,p1.x)+kernelmatrix(ker,Hy,Hy,p1.y)+kernelmatrix(ker,Hx,Hy,p1.xy)+kernelmatrix(ker,Hy,Hx,p1.xy)+kernelmatrix(ker,[Hx;Hy],[Hx;Hy],p1.z);
    K2 = kernelmatrix(ker,Hx,Hx2,p1.x)+kernelmatrix(ker,Hy,Hy2,p1.y)+kernelmatrix(ker,Hx,Hy2,p1.xy)+kernelmatrix(ker,Hy,Hx2,p1.xy)+kernelmatrix(ker,[Hx;Hy],[Hx2;Hy2],p1.z);
	    
end

K  = K';
K2 = K2';
