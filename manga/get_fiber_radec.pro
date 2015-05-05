pro get_fiber_radec, slitMap, ifuDesign, fNum, fitsFile, wave, all=all, plot=plot

;; Find out and plot the (RA, DEC) of fibers given slitmap, ifuDesign, and the name of 
;; the mgSFrame or mgCFrame file name 

    slit = yanny_readone(slitMap, 'SLITMAP', hdr=slitHead)
    ; Locate the bundle 
    bundleIndex = where(slit.ifudesign EQ ifuDesign)
    if (bundleIndex[0] NE -1) then begin 
        bundle = slit[bundleIndex]
    endif else begin 
        message, 'Can not find your IFUDesign !' + string(ifuDesign)
    endelse
    ; Locate the fiber 
    fiberIndex = where(bundle.fnum EQ fNum)
    if (fiberIndex[0] NE -1) then begin 
        fiber = bundle[fiberIndex]
    endif else begin 
        message, 'Can not find your FNUM !' + string(fNum)
    endelse
    ; Get the image header !!! NOT SURE THIS IS USED
    img  = mrdfits(fitsFile, 0, fitsHead)
    ; 
    mdrp_astrometry, xfiber, yfiber, bundle, slit_head, fitsHead, [wave], /quick
    ; 
    raFib  = bundle[0].ra - xfiber / 3600.D / cos(bundle[0].dec * !DPI/180.0)
    decFib = bundle[0].dec - yfiber / 3600.D

    nFib = n_elements(raFib)
    if keyword_set(all) then begin 
        print, "#### IFUDESIGN is " + string(ifuDesign)
        print, "#    FNUM     RA_FIBER     DEC_FIBER" 
        for ii = 0, (nFib - 1), 1 do begin 
            print, string(bundle[ii].fnum) + "    " + string(raFib[ii]) + "    " +string(decFib[ii])
        endfor 
    endif else begin 
        print, "#### IFUDESIGN is " + string(ifuDesign)
        print, "#    FNUM     RA_FIBER     DEC_FIBER" 
        print, fNum, raFib[fiberIndex], decFib[fiberIndex]
    endelse

    if keyword_set(plot) then begin 
        set_plot, 'PS'
        psName = "bundle_" + strcompress(string(ifuDesign), /remove_all) + "_fibers.eps"
        device, filename=psName, /color, /iso, /times
        !p.font=0
        !p.thick=2
        !p.charsize=1
        !x.thick=3
        !y.thick=3
        plotsym, 0 , 6

        cgPlot, raFib, decFib, psym=9, xs=1, ys=1, color=cgColor('Blue'), xtitle='RA (deg)', ytitle='DEC (deg)'

        for jj = 0, (nFib - 1), 1 do begin 
            cgText, raFib[jj], decFib[jj], strcompress(string(bundle[jj].fnum), /remove_all), alignment=0.5, color=cgColor('Red'), charsize=1.0, /data
        endfor

        device, /close_file
    endif 
end

pro testFiberRaDec 

    slitMap   = 'slitmap-8479-57095-01.par'
    ifuDesign = 12701 
    fNum      = 2
    fitsFile  = 'mgSFrame-b1-00196609.fits.gz'

    wave = 5000.0

    getFiberRaDec, slitMap, ifuDesign, fNum, fitsFile, wave, /all, /plot

end
