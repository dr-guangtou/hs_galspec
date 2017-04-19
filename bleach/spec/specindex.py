"""@file specindex.py
All the classes that deal with spectral index.
"""

from __future__ import (division, print_function, absolute_import,
                        unicode_literals)


class SpecIndex(object):
    """The base class for all other kinds of spectral indices.
    """

#########################################################################################
#
# Our class hierarchy is:
#
#    SpecIndex
#        --- LickIndex
#    SpecIndexList
#
# Here we define the rest of these classes, and implement some common functions
#
#########################################################################################
