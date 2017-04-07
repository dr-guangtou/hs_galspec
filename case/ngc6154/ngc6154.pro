pro ngc6154

    readcol, 'ngc4889_sl.txt', w1, f1, e1, flag1, format='(F,F,F,I)', $
        delimiter=' '

    readcol, 'ngc6154_sl.txt', w2, f2, e2, flag2, format='(F,F,F,I)', $
        delimiter=' '

    readcol, 'z1_s8k_robust.txt', w3, f3, e3, flag3, format='(F,F,F,I)', $
        delimiter=' '
    readcol, 'z1_s2k_robust.txt', w4, f4, e4, flag4, format='(F,F,F,I)', $
        delimiter=' '

    f2_conv = hs_spec_convolve(w2, f2, 153.0, 350.0)

    wn1 = 8140.0
    wn2 = 8160.0 
    ww1 = 8520.0 
    ww2 = 8550.0

    norm1 = median(f1[where(w1 GE wn1 AND w1 LE wn2)])
    norm2 = median(f2_conv[where(w2 GE wn1 AND w2 LE wn2)])
    norm3 = median(f3[where(w3 GE wn1 AND w3 LE wn2)])
    norm4 = median(f4[where(w4 GE wn1 AND w4 LE wn2)])

    ;; Set up the figure 
    mydevice = !d.name 
    !p.font = 0 
    psxsize=28 
    psysize=16
    set_plot, 'PS' 
    ;; Start the plot 
    device, filename='ngc6154_8200.eps', font_size=8.5, /encapsulated, /color, /bold, $
        set_font='TIMES-ROMAN', xsize=psxsize, ysize=psysize

    cgPlot, w1, f1/norm1, xs=1, xrange=[wn1, ww2], yrange=[0.83, 1.05], $
        color=cgColor('black'), thick=8.0, xtitle='Wavelength', ytitle='Normalized Flux', $
        charsize=2.5, charthick=2.0, position=[0.05, 0.12, 0.99, 0.99], $
        xthick=6.5, ythick=6.5, yticklen=0.015, xticklen=0.05, $
        xminor=5, yminor=5, /noerase, ytickformat='(A1)'

    cgPlot, w3, f3/norm3, /overplot, color=cgColor('red'), thick=8.0 

    ;cgPlot, w2, f2/norm2, /overplot, color=cgColor('blue'), thick=4.0
    cgPlot, w2, f2_conv/norm2, /overplot, color=cgColor('blue'), thick=8.0

    device, /close 
    set_plot, mydevice

end
