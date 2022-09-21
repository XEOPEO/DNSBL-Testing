# DNSBL-Testing
Script is used to test your DNS Server/Provider on blocklist capability.  
Recommended test blocklists are Abuse.ch and Firebog.net  
This can take a long time when using the `dnsbl-test.sh` since it is sequential.

For faster testing I recommend to split the blocklist into multiple shortlists with the `split` command.  
eg. `split -l 10000 <blocklist_file> wordfiles/` This will split the main blocklist into list of 10000 entries.  
For this you can use the `dnsbl-multi.sh` which uses the `dnsbl-sub.sh` to create multiple instances of the test script.  
This splitted parts have to be under the folder `wordfiles`  
Also the testing will provide results which will simply write the number of domains blocked per test instance.  
Those are written into the `results` folder with each test outputting its own file.
