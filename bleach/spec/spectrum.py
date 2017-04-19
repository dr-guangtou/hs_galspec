"""@file spectrum.py
All the classes that deal with basic spectrum data.
"""

from __future__ import (division, print_function, absolute_import,
                        unicode_literals)


class Spectrum(object):
    """The base class for all other kinds of spectral indices.
    """

#########################################################################################
#
# Our class hierarchy is:
#
#    Spectrum
#        --- Continuum
#    SpecList
#
# Here we define the rest of these classes, and implement some common functions
#
#########################################################################################
