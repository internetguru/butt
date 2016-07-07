NAME
====

Bash Unit Testing Tool

SYNOPSIS
========

butt [-hlsvVw] [--color[=WHEN]] FILE

DESCRIPTION
===========

**Bash Unit Testing Tool**\ [1] (hereinafter referred as the 'BUTT') runs and
evaluates a set of commands according to expected results. It can serve as CI
component of Bash scrip development.

It is an alternative to **bats**\ [2] command with following
improvements:

- predefined comparison (assert) functions,
- distinguish standard and error output,
- verbose mode,
- advanced user functions support.

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

INSTALL
=======

From dist package
-----------------

``./install``, resp. ``./uninstall``

Tip: Specify destination directories
    E.g. ``MANPATH=/usr/share/man/man1 ./install``

From source
-----------

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
    see file VERSION
Actual change log
    see file CHANGELOG

EXIT STATUS
===========

0
    No problems occurred.
1
    Generic error code.
2
    Parse or invalid option error.

SEE ALSO
========

`BUTT[1] <https://github.com/InternetGuru/butt/>`__

`Bats[2] <https://github.com/sstephenson/bats>`__

REPORTING BUGS
==============

`Issue tracker <https://github.com/InternetGuru/butt/issues>`__

COPYRIGHT
=========

Copyright (C) 2016 `InternetGuru <https://www.internetguru.cz>`__

`License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>`__

This is free software: you are free to change and redistribute it.

There is NO WARRANTY, to the extent permitted by law.

DONATION
========

If you find this program useful, please **send a donation** to its developers
to support their work. If you use this program at your workplace, please
suggest that the company make a donation. We appreciate contributions of any
size. Donations enable us to spend more time working on this package, and help
cover our infrastructure expenses.

If you’d like to make a donation of any value, please send it to the following
PayPal address:

`PayPal Donation <https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=UZHQ28P4VYHWY>`__

Since we aren’t a tax-exempt organization, we can’t offer you a tax deduction.
But for all donations over 50 USD, we’d be happy to recognize your
contribution on the **BUTT** page[1] and on this README file (including manual
page) for the next release.

We are also happy to consider making particular improvements or changes, or
giving specific technical assistance, in return for a substantial donation
over 100 USD. If you would like to discuss this possibility, write us at
info@internetguru.cz.

Another possibility is to pay a software maintenance fee. Again, write us
about this at info@internetguru.cz to discuss how much you want to pay and how
much maintenance we can offer in return.

Thanks for your support!

DONORS
======

`Faculty of Information Technology, CTU Prague <https://www.fit.cvut.cz/en>`__

AUTHORS
=======

-  Pavel Petržela pavel.petrzela@internetguru.cz

-  Jiří Pavelka jiri.pavelka@internetguru.cz
