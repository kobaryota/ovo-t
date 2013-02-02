$Dkoud = "/home/milkyovo/koushindata";
$Dkoushin = "/home/milkyovo/koushin";

system("mv $Dkoushin/*.txt $Dkoud");
system("rm -r $Dkoushin/*");
