pro ugc05936 

    hvdisp_home="/Users/songhuang/Dropbox/work/project/hs_sdssspec/"
    index_list="hs_index_all.lis"

    spec1 = 'spec-2090-53463-0519_test.fits'
    spec2 = 'spec-2241-54169-0542_test.fits'

    data1 = mrdfits(spec1, 1)
    data2 = mrdfits(spec2, 1)

    flux1_conv = hs_spec_convolve(data1.wave, data1.flux,  201.44, 350.0)
    sig1_conv  = hs_spec_convolve(data1.wave, data1.error, 201.44, 350.0)

    flux2_conv = hs_spec_convolve(data2.wave, data2.flux,  369.67, 370.0)
    sig2_conv  = hs_spec_convolve(data2.wave, data2.error, 369.67, 370.0)


    ind1 = hs_spec_index_batch(data1.wave, flux1_conv, /toair, prefix='ugc05936', $
                               index_list=index_list, hvdisp_home=hvdisp_home, $
                               error=sig1_conv, /save_fits)

    ind2 = hs_spec_index_batch(data2.wave, flux2_conv, /toair, prefix='ngc4889', $
                               index_list=index_list, hvdisp_home=hvdisp_home, $
                               error=sig2_conv, /save_fits)

end
