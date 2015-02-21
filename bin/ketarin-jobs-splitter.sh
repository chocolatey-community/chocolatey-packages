#!/usr/bin/env bash

java -jar /usr/share/maven-repo/net/sf/saxon/Saxon-HE/9.x/Saxon-HE-9.x.jar -s:"$1" -xsl:ketarin-jobs-splitter.xsl -o:null.xml
