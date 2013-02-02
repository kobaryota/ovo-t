$Dnew = "/home/milkyovo/singledata"; #新しいsingleのデータ
$OVOAUTO = "/home/milkyovo";		#OVO-AUTO
$Dprg = "/home/milkyovo/program/";

system("ls $OVOAUTO/singledata/ > $Dprg/newsinList.txt");
system("cat $Dprg/newsinList.txt >> $Dprg/oldsinList.txt");
system("sort $Dprg/oldsinList.txt | uniq -u > $Dprg/single.txt");	#前回のデータと新しいデータの差を表示

open(IN, "$Dprg/single.txt");
@file = <IN>;
chomp @file;
close(IN);

foreach $name (@file){
	system("cp $Dnew/$name $OVOAUTO/koushin/\n");	#新しいデータを別のdirに移動
}

system("ls $OVOAUTO/singledata > $Dprg/oldsinList.txt");	#新しいデータに置き換える
