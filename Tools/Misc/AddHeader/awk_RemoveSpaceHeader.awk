BEGIN{
    FS=""
    RS="\n"
    OFS=""
    ORS="\n"
    lineCounter=0
    isSeeUnemptyLine=0
}
{
    lineCounter+=1
    
    if(isSeeUnemptyLine==0)
    {
	if($0!="") #^[ \t]*$
	{	    	    
	    isSeeUnemptyLine=1
	}
	else
	{
	    next
	}
    }    
    print $0
}
