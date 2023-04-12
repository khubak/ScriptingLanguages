import re
import sys
import urllib.request
from urllib.parse import urlparse

links = []
hosts = []
emails = []
img_urls = []

if (len(sys.argv) != 2):
    print("Navedi samo jedan argument!")
    exit(1)

stranica = urllib.request.urlopen(sys.argv[1])
mybytes = stranica.read()
mystr = mybytes.decode("utf8")
print(mystr)

links = re.findall(r'href=[\'"]?([^\'" >]+)', mystr)
print(links)

for link in links:
    url = urlparse(link)
    hosts.append(url.netloc)

hosts_1 = list(dict.fromkeys(hosts))
print(hosts_1)

my_dict = {i:hosts.count(i) for i in hosts}
print(my_dict)

emails = re.findall(r'[\w\.-]+@[\w\.-]+', mystr)
print(emails)

img_urls = re.findall('<img src="([^"]+)"', mystr)
print(len(img_urls))