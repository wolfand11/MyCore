BEGIN{
    FS=""
    RS="\n"
    OFS=""
    ORS="\n"
    isSeeUnemptyLine=0
    
    lineCounter=0
    exitCode=1
    if(reg=="")
    {	
	exit exitCode
    }
    removeLineRegExp=reg
}
{
    lineCounter++    
    if(lineCounter==1)
    {	
	if($0~removeLineRegExp)
	{
	    #print "match:" removeLineRegExp
	    exitCode=0
	    next	    
	}
    }
    print $0
}
END{
    exit exitCode
}