#!/usr/bin/perl
use strict;
use JSON;
use Data::Dumper;


my @name_file_json = ();

opendir (DIR, "/home/vitalii/university/perl/perl_2016/sem1/adv_json/data/") or die $!;
while(my $fname = readdir DIR) {
  if($fname != '.' or $fname !='..' ){
  	#print "$fname\n";
  	push(@name_file_json,$fname);
  }
}
closedir DIR;

#print $name_file_json[0];
my @array_json = ();
my %hash = ();
foreach my $i (@name_file_json) {
	my $fname;
	my $fname_hash =$i;
	$fname ="/home/vitalii/university/perl/perl_2016/sem1/adv_json/data/".$i;
	open(F1,$fname);
	my $data = <F1>;
	my $perl_scalar = decode_json($data);
	foreach my $key(sort keys $perl_scalar){
		##print "$key => $hash{$key}\n"; #отсортирует в алфавитном порядке по значениям ключа
	}

	my $json = encode_json($perl_scalar);
	#print $json;
	#push(@array_json,$json);
	$hash{$fname_hash} = $json;
	
	#print $$perl_scalar{a};
	#print Dumper($perl_scalar);
	

	#print decodeJSON($data);
	#print decodeJSON(<F1>);
	# body...
}

#print @array_json;
#print %hash;
my $name_dir = 0;
foreach my $value1(values %hash){
	my  $local_i = 0;
	#print $hash{$value1};
	#print "$value1\n"; #возвращает список значений хеша
	foreach my $value2(values %hash){
		if($value1 eq $value2){
			if($local_i == 0){
				mkdir '/home/vitalii/university/perl/perl_2016/sem1/adv_json/data/'.$name_dir, 0777;
				#open(my $fname, '>', );
				#print $fname "Мой первый отчет, сгенерированный с помощью perl\n";
				#close $fname;
				
				#print '/home/vitalii/university/perl/perl_2016/sem1/adv_json/data/'.$name_dir.$text;

			}
			
			#open(my $fname, '>', '/home/vitalii/university/perl/perl_2016/sem1/adv_json/data/'.$name_dir.%hash{value2});


			$name_dir++;
			#print '=)';
		}

	}
}

#print Dumper compare \%a, \%b;
#print Dumper compare \%a, \%c;
