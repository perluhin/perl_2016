use Data::Dumper;

open(F1,"text.txt");
my $list= [];
$line=<F1>;
#убираю первую строчку из вывода - Итого 9672
$line=<F1>;
while($line){
	my @local_list = [];
	
	@line=split(/;/,$line);
	#удаляем \n
	if($line[8]){	
		chomp($line[8]);
	}
	push $local_list[0],@line;	
	push($list,@local_list);
	
	$line = <F1>;
}
print Dumper($list);
