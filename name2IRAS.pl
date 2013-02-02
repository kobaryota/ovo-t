###変換名一覧中に2つ以上一致するものがあった場合の対応が不完全
###shファイル等に吐き出して、目視確認が必要
###該当無しの場合は、nohitに移動されるので確認し、変換名一覧を充実させる
#!/usr/bin/perl

$Dkoushin = "/home/milkyovo/koushindata";
$Dprg = "/home/milkyovo/program";
$Ddrp = "/home/milkyovo/Dropbox";

system("ls $Dkoushin/*.txt > $Dprg/sample.txt");
$band = "\_K\_";
$no = 0;
open(IN,"$Dprg/sample.txt");					#解析結果txtの一覧を読み込む。
while ($line = <IN>)  {
	chomp $line;
	($kou,$data) = split (/\/koushindata\//, $line);
	($name,$ushiro) = split (/\_K\_/, $data);	#_K_の前後で分ける。
	$name =~ s/\+/\\\+/c;				#+が上手く認識されないため\を付ける。
	$ushiro =~ s/\*//;				#ファイル名の最後に*が付いている場合は消す。
	open(OUT,">> $Dprg/furiwake.sh");
	open(IN2,"$Dprg/allrename.txt");#変換名一覧を読み込む。
	while ($pattern = <IN2>){
		chomp $pattern;
		if($pattern =~ / $name,/i){		#スペースと,に囲まれた天体名を大小文字区別せず一覧と比較
			++$no;				#一致するものがあればnoに1を足す
			if($no == 1){			#noが1、つまり一致したものが1つなら
				($real,$two) = split (/,\s/,$pattern);
				$name =~ s/\\//g;	#+を認識させるための\を消す
				$real =~ s/ //;		
				print (OUT "cp $Dkoushin/$name$band$ushiro $Dkoushin/$real$band$ushiro\n");		#ファイル名変換
				print (OUT "mv $Dkoushin/$real$band$ushiro $Ddrp\n");	#inputboxにcopy
			}
			if($no >= 2){
				#print (OUT "cp $Dkoushin/$name$band$ushiro $Doub/$name$band$ushiro\n");
			}	
		}
	}
	close(IN2);
	if($no == 0){				#一致するものが無い場合
		$name =~ s/\\//g;
		print (OUT "mv $Dkoushin/$name$band$ushiro $Ddrp\n");	#nohitというdirに転送
	}
	$no = 0;
}
close(OUT);
close(IN);
system("sh /home/milkyovo/program/furiwake.sh");
#system("rm $Dprg/sample.txt");
system("rm /home/milkyovo/program/furiwake.sh");
system("rm $Dkoushin/*.txt");
