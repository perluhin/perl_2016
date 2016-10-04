=head1 DESCRIPTION

Эта функция должна принять на вход арифметическое выражение,
а на выходе дать ссылку на массив, состоящий из отдельных токенов.
Токен - это отдельная логическая часть выражения: число, скобка или арифметическая операция
В случае ошибки в выражении функция должна вызывать die с сообщением об ошибке

Знаки '-' и '+' в первой позиции, или после другой арифметической операции стоит воспринимать
как унарные и можно записывать как "U-" и "U+"

Стоит заметить, что после унарного оператора нельзя использовать бинарные операторы
Например последовательность 1 + - / 2 невалидна. Бинарный оператор / идёт после использования унарного "-"

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

sub tokenize {
	chomp(my $expr = shift);
	my @res;
	my @list = split //,$expr;
	my %hash = ('+' => '1',
				'-' => '1',
				'*' => '1',
				'/' => '1')
	eval {
		# do something risky...
		my $n = 0;
		foreach my $i (0 .. $#list) {
			if($i<$#list-2){
				if( $hash{$i} == 1 and $hash{$i+1} == 1 and $hash{$i+1} == 1  ){
					die 'Error'
				}

			}
		}
		if($list[0]=='-'){
			$list[0] = 'U-';
		}
		if($list[0]=='+'){
			$list[0] = 'U+';
		}
		foreach my $i (1 .. $#list) {

			if ( ( $list[$i-1]=='-' )and( ($list[$i]=='-')or($list[$i]=='+') ) ){
				$list[$i] = 'U-';
			}
			if ( ( $list[$i-1]=='+' )and( ($list[$i]=='-')or($list[$i]=='+') ) ){
				$list[$i] = 'U+';
			}

		}
	};
	if ($@) {
		# handle failure...
		die $@;
	}
	
	# ...

	return \@res;
}

1;

