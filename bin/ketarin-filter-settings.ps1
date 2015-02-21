XslCompiledTransform xslt = new XslCompiledTransform();
xslt.Load("ketarin-template.xsl");

// Execute the transform and output the results to a file.
// xslt.Transform("file.xml", "null.xml");

// file.xml needs to be the command line argument
// null.xml can be /dev/null or >NUL or something

Write-Host "Num Args:" $args.Length;
foreach ($arg in $args)
{
    Write-Host "Arg: $arg";
}
