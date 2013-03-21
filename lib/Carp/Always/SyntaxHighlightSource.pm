package Carp::Always::SyntaxHighlightSource;

use 5.010001;
use strict;
use warnings;
use Carp::SyntaxHighlightSource;

our $VERSION = '0.01'; # VERSION

our %options;

sub import {
    my $class = shift;
    %options = @_;
}

sub _warn {
    if ($_[-1] =~ /\n$/s) {
        my $arg = pop @_;
        $arg =~ s/ at .*? line .*?\n$//s;
        push @_, $arg;
    }
    $Carp::SyntaxHighlightSource::CarpLevel = 1;
    warn Carp::SyntaxHighlightSource::longmess_heavy(join('', grep { defined } @_), %options);
}

sub _die {
    if ($_[-1] =~ /\n$/s) {
        my $arg = pop @_;
        $arg =~ s/ at .*? line .*?\n$//s;
        push @_, $arg;
    }
    $Carp::SyntaxHighlightSource::CarpLevel = 1;
    die Carp::SyntaxHighlightSource::longmess_heavy(join('', grep { defined } @_), %options);
}

my %OLD_SIG;

BEGIN {
    @OLD_SIG{qw(__DIE__ __WARN__)} = @SIG{qw(__DIE__ __WARN__)};
    $SIG{__DIE__} = \&_die;
    $SIG{__WARN__} = \&_warn;
}

END {
    no warnings 'uninitialized';
    @SIG{qw(__DIE__ __WARN__)} = @OLD_SIG{qw(__DIE__ __WARN__)};
}

1;
#ABSTRACT: Carp::Always, but show syntax-highlighted source code context


__END__
=pod

=head1 NAME

Carp::Always::SyntaxHighlightSource - Carp::Always, but show syntax-highlighted source code context

=head1 VERSION

version 0.01

=head1 SYNOPSIS

 % perl -MCarp::Always::SyntaxHighlightSource script.pl

=head1 DESCRIPTION

=head1 CREDITS

Modified from L<Carp::Source::Always>.

=head1 SEE ALSO

L<Carp::Always>

L<Carp::Source> and L<Carp::Source::Always>

L<carpa>

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

