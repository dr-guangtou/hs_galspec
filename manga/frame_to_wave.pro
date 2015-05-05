pro frame_to_wave 

    spawn, 'ls *.fits.gz', list 

    num = n_elements(list)
    print, list

    for i = 0, (num - 1), 1 do begin 

        name = list[i]
        print, '#### READING FILE ' + string(name)

        wset = mrdfits(name, 4, hd4)
        traceset2xy, wset, dum, loglam 
        lam = 10.0^loglam 
    
        temp = (strsplit(name, '.', /extract))[0]
        output = temp + '_wave.fits'
    
        mwrfits, lam, output, /create 
        print, '#### DONE !'

    endfor 

end
