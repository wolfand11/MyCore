BEGIN{
    FS=""
    RS="\n"
    OFS=""
    ORS=""
    lineCounter=0
    exitCode=1
}
{
    lineCounter+=1
    if($0!="")
    {
	isSeeUnemptyLine=1
	exitCode=0
	print $0
	exit
    }
    else
    {
	next	
    }
}
END{
    exit exitCode
}