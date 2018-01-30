#!/usr/apps/bin/perl
#
# perl program to try the convergence for different functions 
# when using Newtoon's method for f(x) = 0
# run with : perl newton.p
#
#
# Here is the generic file
$cmdFile="./newtonS.f90.Template";
$outFile="./newtonS.f90";

# Functions to test

@array_f = ("exp(x)-1.d0", "x*x", "sin(x)", "exp(-1.d0/x)");
@array_fp = ("exp(x)", "2.d0*x", "cos(x)", "exp(-1.d0/x)/x**2");
@array_guess = ("1.d0", "1.d0", "0.99d0" ,"0.01d0");

for( $m = 0; $m < 4; $m = $m+1){
    # Open the Template file and the output file. 
    open(FILE,"$cmdFile") || die "cannot open file $cmdFile!" ;
    open(OUTFILE,"> $outFile") || die "cannot open file!" ;
    # Setup the outfile based on the template
    # read one line at a time.
    while( $line = <FILE> )
    {
	# Replace the the stings by using substitution
	# s
	$line =~ s/\bFFFF\b/$array_f[$m]/;
	$line =~ s/\bFPFP\b/$array_fp[$m]/;
	$line =~ s/\bGGGG\b/$array_guess[$m]/;
	print OUTFILE $line;
        # You can always print to secreen to see what is happening.
        # print $line;
    }
    # Close the files
    close( OUTFILE );
    close( FILE );
    
    # Run the shell commands to compile and run the program
    system("gfortran $outFile");
    system("./a.out > apa.txt");

    open(FILE,"apa.txt") || die "cannot open file" ;
    # Setup the outfile based on the template
    # read one line at a time.
    while( $line = <FILE> )
    {
	# Replace the the stings by using substitution
	# s
	$line =~ s/\s+/ , /g;
	$line =  $line . "\n";
	$line =~ s/ , $/ /;
	# $line =~ s/ , / /;
	$line =~ s/^ , / /;
#"s/^ , / /;".
	print $line; 
    }
    close( FILE );
}

exit

