# BLEACH

---- Song Huang 2017/04/18 ----

## Basic design

### Basic Classes (`spec`)

    * Spectrum
        - Continuum
            - BlackBodyContinuum
            - PolynomialContinuum
        - SpectraCube
        - SpectraList

    * EmissionLine
        - SkyLine
        - BalmerEmission
        - ForbiddenLine

    * AbsorptionLine
        - BalmerAbsorption
        - MetalAbsorption

    * SpecIndex
        - LickIndex

    * SSPLibrary
        - MILES
        - MIUSCAT
        - FSPS

### Data IO (`io`)

    - Download/Load SDSS/BOSS spectra
    - Load MILES/MIUSCAT spectra
    - Interface to Python-FSPS
    - Load WAGGS spectra
    - Load CALIFA/MaNGA/SAMI

### Display (`plotting`)

    - Display the spectrum nicely (use the APOGEE library by Jo Bovy as good example)
    - Display the spectral index nicely (see old IDL code)

### Basic functions (`tools`)

    - Correct the dust extinction
    - Velocity shift / Redshift correction
    - Move the spectrum from Vacuum to Air
    - Smooth the spectrum (see prospector by Ben Johnson)
    - Fit and subtraction the continuum
    - Normalize the spectrum in a wavelength window
    - Measure magnitude based on the spectra and filter

### Fitting (`fitting`)

    - Deal with Starlight
    - Deal with pPXF
    - Deal with Prospector
    - Fit Emission lines with multi-Gaussian/Lorentz models

-----

# Demonstration

    * Deal with WAGGS spectra using Python
