###�Ѵ�̾�������2�İʾ���פ����Τ����ä������б����Դ���
###sh�ե����������Ǥ��Ф��ơ��ܻ��ǧ��ɬ��
###����̵���ξ��ϡ�nohit�˰�ư�����Τǳ�ǧ�����Ѵ�̾�����򽼼¤�����
#!/usr/bin/perl

$Dkoushin = "/home/milkyovo/koushindata";
$Dprg = "/home/milkyovo/program";
$Ddrp = "/home/milkyovo/Dropbox";

system("ls $Dkoushin/*.txt > $Dprg/sample.txt");
$band = "\_K\_";
$no = 0;
open(IN,"$Dprg/sample.txt");					#���Ϸ��txt�ΰ������ɤ߹��ࡣ
while ($line = <IN>)  {
	chomp $line;
	($kou,$data) = split (/\/koushindata\//, $line);
	($name,$ushiro) = split (/\_K\_/, $data);	#_K_�������ʬ���롣
	$name =~ s/\+/\\\+/c;				#+����꤯ǧ������ʤ�����\���դ��롣
	$ushiro =~ s/\*//;				#�ե�����̾�κǸ��*���դ��Ƥ�����Ͼä���
	open(OUT,">> $Dprg/furiwake.sh");
	open(IN2,"$Dprg/allrename.txt");#�Ѵ�̾�������ɤ߹��ࡣ
	while ($pattern = <IN2>){
		chomp $pattern;
		if($pattern =~ / $name,/i){		#���ڡ�����,�˰Ϥޤ줿ŷ��̾���羮ʸ�����̤������������
			++$no;				#���פ����Τ������no��1��­��
			if($no == 1){			#no��1���Ĥޤ���פ�����Τ�1�Ĥʤ�
				($real,$two) = split (/,\s/,$pattern);
				$name =~ s/\\//g;	#+��ǧ�������뤿���\��ä�
				$real =~ s/ //;		
				print (OUT "cp $Dkoushin/$name$band$ushiro $Dkoushin/$real$band$ushiro\n");		#�ե�����̾�Ѵ�
				print (OUT "mv $Dkoushin/$real$band$ushiro $Ddrp\n");	#inputbox��copy
			}
			if($no >= 2){
				#print (OUT "cp $Dkoushin/$name$band$ushiro $Doub/$name$band$ushiro\n");
			}	
		}
	}
	close(IN2);
	if($no == 0){				#���פ����Τ�̵�����
		$name =~ s/\\//g;
		print (OUT "mv $Dkoushin/$name$band$ushiro $Ddrp\n");	#nohit�Ȥ���dir��ž��
	}
	$no = 0;
}
close(OUT);
close(IN);
system("sh /home/milkyovo/program/furiwake.sh");
#system("rm $Dprg/sample.txt");
system("rm /home/milkyovo/program/furiwake.sh");
system("rm $Dkoushin/*.txt");
