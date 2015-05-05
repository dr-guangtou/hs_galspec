pro get_met_n2, nii_6584, ha_6564

    ratio = alog10( nii_6584 / ha_6564 ) 
    log_oh = 9.12 + 0.73 * ratio 

    print, log_oh 

    log_oh_solar = 8.66
    oh_ratio = 10.0^log_oh / 10.0^log_oh_solar
    
    print, oh_ratio

end
