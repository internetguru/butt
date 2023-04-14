NAME
====

Bash Unit Testing Tool


SYNOPSIS
========

butt [-hlsvVw] [--color[=WHEN]] FILE


DESCRIPTION
===========

**Bash Unit Testing Tool** runs and evaluates a set of commands according to expected results. It can serve as a CI testing component of Bash scrip development.

The 'butt' command is an alternative to the 'bats' command, offering the following improvements:

- Predefined comparison (assert) functions
- Distinguish standard and error output
- Verbose mode
- Advanced user functions


OPTIONS
=======

\--color[=WHEN], --colour[=WHEN]
    Use markers to highlight command status; WHEN is 'always', 'never', or
    'auto'.
\-h, --help
    Print help.
\-l NUM, --limit=NUM
    Limit the number of running tests.
\-s NUM, --skip=NUM
    Skip the number of tests.
\-v, --verbose
    Verbose mode.
\-V, --version
    Print version number.
\-w PATH, --working-dir=PATH
    Run tests in specific PATH (and do not remove it).


INSTALLATION
============

From a dist package
-------------------

``./install``, resp. ``./uninstall``

Tip: Specify destination directories
    E.g. ``MANPATH=/usr/share/man/man1 ./install``

From the source
---------------

``./configure && make && compiled/install``

Make dist package from source
    ``./configure && make dist``
Tip: Specify variables
    E.g. ``./configure && PREFIX=/usr SYSTEM=babun make dist``
Tip: Install rst2man
    ``apt-get install python-docutils`` or
    ``pip install docutils``


HISTORY
=======

Actual version
    see the VERSION file
Actual changes
    see the CHANGELOG file


EXIT CODES
==========

0
    No problems occurred.
1
    Generic error code.
2
    Parse or invalid option error.


REPOSITORY
==========

`Bash Unit Testing Tool <https://github.com/internetguru/butt/>`__


REPORTING BUGS
==============

`Issue tracker <https://github.com/internetguru/butt/issues>`__


AUTHOR
======

Written by Pavel Petrzela and George J. Pavelka.


COPYRIGHT
=========

Copyright © 2016 `Internet Guru <https://www.internetguru.io>`__

`License GPLv3+: GNU GPL version 3 or later <https://www.gnu.org/licenses/gpl-3.0.html>`__

This is free software: you are free to change and redistribute it.

There is NO WARRANTY, to the extent permitted by law.


DONATION
========

If you find this script useful, please consider making a donation to support its developers. We appreciate any contributions, no matter how small. Donations help us to dedicate more time and resources to this project, including covering our infrastructure expenses.

`PayPal Donation <https://www.paypal.com/donate/?hosted_button_id=QC7HU967R4PHC>`__

Please note that we are not a tax-exempt organization and cannot provide tax deductions for your donation. However, for donations exceeding $500, we would like to acknowledge your contribution on project's page and in this file (including the man page).

Thank you for your continued support!


HONORED DONORS
==============

`Czech Technical University in Prague <https://www.fit.cvut.cz/en>`__
