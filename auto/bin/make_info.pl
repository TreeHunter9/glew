#!/usr/bin/perl
#
# Copyright (C) 2003 Marcelo E. Magallon <mmagallo@debian.org>
# Copyright (C) 2003 Milan Ikits <milan.ikits@ieee.org>
#
# This program is distributed under the terms and conditions of the GNU
# General Public License Version 2 as published by the Free Software
# Foundation or, at your option, any later version.

use strict;
use warnings;

do 'bin/make.pl';

#---------------------------------------------------------------------------------------

# function pointer definition
sub make_pfn_info($%)
{
    my $name = prefixname($_[0]);
    return "  glewInfoFunc(\"$_[0]\", $name == NULL);";
}

#---------------------------------------------------------------------------------------

my @extlist = ();
my %extensions = ();

if (@ARGV)
{
    @extlist = @ARGV;
} else {
    local $/;
    @extlist = split "\n", (<>);
}

foreach my $ext (sort @extlist)
{
    my ($extname, $exturl, $types, $tokens, $functions, $exacts) = parse_ext($ext);
    my $extvar = $extname;
    my $extvardef = $extname;
    $extvar =~ s/GL(X*)_/GL$1EW_/;

    make_separator($extname);
    print "#ifdef $extname\n\n";
    print "static void _glewInfo_$extname (void)\n{\n  glewPrintExt(\"$extname\", $extvar);\n";
    output_decls($functions, \&make_pfn_info);
    print "}\n\n";
    print "#endif /* $extname */\n\n";
}