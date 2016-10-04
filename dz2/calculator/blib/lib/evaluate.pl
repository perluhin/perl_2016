=head1 DESCRIPTION

Эта функция должна принять на вход ссылку на массив, который представляет из себя обратную польскую нотацию,
а на выходе вернуть вычисленное выражение

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

sub evaluate {
	my $rpn = shift;

	my @stack_list;
	eval{
		for (@$rpn) {
			if (/\d+/) 			{ push(@stack_list, $_) }
			elsif (/U[-]/) 			{ push(@stack_list, -pop(@stack_list))}
			elsif (/U[+]/) 			{  }
			else {
				my $one = pop(@stack_list);
				my $two = pop(@stack_list);
				given ($_){
					when (m{^[+]$}) {push(@stack_list, $two +  $one)}
					when (m{^[-]$}) {push(@stack_list, $two -  $one)}
					when (m{^[*]$}) {push(@stack_list, $two *  $one)}
					when (m{^[/]$}) {push(@stack_list, $two /  $one)}
					when (m{^\^$} ) {push(@stack_list, $two ** $one)}	
				}
			}
		}
	1} or die "Error evaluate";

	return pop(@stack_list);

}

1;
