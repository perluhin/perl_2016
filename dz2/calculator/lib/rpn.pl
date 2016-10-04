=head1 DESCRIPTION

Эта функция должна принять на вход арифметическое выражение,
а на выходе дать ссылку на массив, содержащий обратную польскую нотацию
Один элемент массива - это число или арифметическая операция
В случае ошибки функция должна вызывать die с сообщением об ошибке

=cut

use 5.010;
use strict;
use warnings;
use diagnostics;
BEGIN{
	if ($] < 5.018) {
		package experimental;
		use warnings::register;
	}
}
no warnings 'experimental';
use FindBin;
require "$FindBin::Bin/../lib/tokenize.pl";

sub is_oper
{
    my $oper = shift;
    return 1 if ($oper eq '+' or $oper eq '-' or $oper eq '*' or
    $oper eq '/' or $oper eq '^' or $oper eq 'U+' or $oper eq 'U-');
    return 0;
}

sub priority
{
    my $oper = shift;
    return 0 if ($oper eq '(');
    return 1 if ($oper eq '+' or $oper eq '-');
    return 2 if ($oper eq '*' or $oper eq '/');
    return 3 if ($oper eq '^' or $oper eq 'U+' or $oper eq 'U-');
}

sub rpn {
	my $expr = shift;
	my $source = tokenize($expr);
	my @rpn;


	my @stack_list;
    for (@{$source})
    {
        if ($_ eq '(')
        {
            push(@stack_list, $_);
        }
        elsif ($_ eq ')')
        {
            while ($stack_list[-1] ne '(')
            {
                push(@rpn, pop(@stack_list));
            }
            pop(@stack_list);
        }
        elsif (is_oper($_))
        {
            while (@stack_list > 0 and priority($_) == 3 ?
                priority($stack_list[-1]) > priority($_) :
                priority($stack_list[-1]) >= priority($_))
            {
                push(@rpn, pop(@stack_list));
            }
            push(@stack_list, $_);
        }
        else
        {
            push(@rpn, ($_+0)."");
        }
    }
    while (@stack_list > 0)
    {
        push(@rpn, pop(@stack_list));
    }
    return \@rpn;
}

1;
