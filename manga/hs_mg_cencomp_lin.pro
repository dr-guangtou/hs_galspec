pro manga_mg_cencomp_lin, file, z 

    flux = mrdfits(file, 1, hdr1) 
    wave = mrdfits(file, 4, hdr4) / (1.0D + z) 

    ind_norm = where( wave GE 5000.0 AND wave LE 5100.0) 

    scale_x = sxpar(hdr1, 'CD1_1') 
    scale_y = sxpar(hdr1, 'CD2_2')
    scale = scale_y * 3600.0   ; in arcsec 

    size_cube = size(flux) 
    dim1 = size_cube[1]
    dim2 = size_cube[2] 
    dim3 = size_cube[3] 
    print, ' DIM : ', dim1, dim2, dim3 

    ima = total(flux, 3) 
    xx = findgen(dim1) * scale 
    yy = findgen(dim2) * scale 

    flux_norm = (flux - flux) * 1.0
    for ii = 0, (dim1 - 1), 1 do begin 
        for jj = 0, (dim2 - 1), 1 do begin 
            temp_spec = flux[ii, jj, *]
            temp_norm = temp_spec / median(temp_spec[ind_norm]) 
            flux_norm[ii, jj, *] = temp_norm 
        endfor 
    endfor 

    ;; center 
    flux_max = max( ima ) 
    pix_cen = where( ima GE (0.85 * flux_max) )
    num_cen = n_elements( pix_cen ) 
    print, 'CEN : ',  num_cen 
    spec_cen_arr = fltarr(num_cen, dim3)
    for ii = 0, ( num_cen - 1 ), 1 do begin 
        ind_temp = pix_cen[ii] 
        ind_ima  = array_indices([dim1, dim2], ind_temp, /dimensions) 
        spec_cen_arr[ii,*] = flux_norm[ind_ima[0], ind_ima[1], *] 
    endfor 
    spec_cen_med = median(spec_cen_arr, dimension=1) 
    spec_cen_avg = avg(spec_cen_arr, 1)
    spec_cen_tot = total(spec_cen_arr, 1) 
    spec_cen_tot = spec_cen_tot / median(spec_cen_tot[ind_norm])
    ;cgPlot, wave, spec_cen_med, /xs, /ys 

    ;; reff 
    pix_ref = where(ima GE (0.1 * flux_max) AND ima LE (0.5 * flux_max))
    num_ref = n_elements( pix_ref ) 
    print, 'REF : ', num_ref
    spec_ref_arr = fltarr(num_ref, dim3)
    for ii = 0, ( num_ref - 1 ), 1 do begin 
        ind_temp = pix_ref[ii] 
        ind_ima  = array_indices([dim1, dim2], ind_temp, /dimensions) 
        spec_ref_arr[ii,*] = flux_norm[ind_ima[0], ind_ima[1], *] 
    endfor 
    spec_ref_med = median(spec_ref_arr, dimension=1) 
    spec_ref_avg = avg(spec_ref_arr, 1)
    spec_ref_tot = total(spec_ref_arr, 1) 
    spec_ref_tot = spec_ref_tot / median(spec_ref_tot[ind_norm])
    ;cgPlot, wave, spec_ref_med, /overplot, color='red' 
    
    spec_cen_use = spec_cen_med 
    spec_ref_use = spec_ref_med
    ;wrange = [8050, 8300]
    ;nrange = [7950, 8050] 
    ;wrange = [5020, 5400]
    ;nrange = [5000, 5050]
    wrange = [6480, 7050]
    nrange = [6490, 6540]
    ind_norm2 = where( wave GE nrange[0] AND wave LE nrange[1] )
    spec_cen_norm1 = spec_cen_use / median(spec_cen_use[ind_norm2]) 
    spec_ref_norm1 = spec_ref_use / median(spec_ref_use[ind_norm2]) 

    cgPlot, wave, spec_cen_norm1, xrange=wrange, /xs, /ys 
    cgPlot, wave, spec_ref_norm1, /overplot, color='red'

end 
