pro getIndex, spec, prefix, veldisp 

    hvdisp_home="/Users/songhuang/Dropbox/work/project/hs_sdssspec/"
    index_list="hs_index_all.lis"

    spec = strcompress(spec, /remove_all) 
    prefix = strcompress(prefix, /remove_all)
    data = mrdfits(spec, 1)

    flux_conv = hs_spec_convolve(data.wave, data.flux,  veldisp, 350.0)
    sig_conv  = hs_spec_convolve(data.wave, data.error, veldisp, 350.0)

    index = hs_spec_index_batch(data.wave, flux_conv, /toair, prefix=prefix, $
                               index_list=index_list, hvdisp_home=hvdisp_home, $
                               error=sig_conv, /save_fits)

end
