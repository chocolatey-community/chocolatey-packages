#!/usr/bin/env bash
# apt-get install libsaxonhe-java

java -jar /usr/share/maven-repo/net/sf/saxon/Saxon-HE/9.x/Saxon-HE-9.x.jar -s:"$1" -xsl:ketarin-template.xsl
