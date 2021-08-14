import re

import requests
import collections
from bs4 import BeautifulSoup

url = 'http://34.150.90.27/'
res = requests.get(url)
html_page = res.content
soup = BeautifulSoup(html_page, 'html.parser')
text = soup.find_all(text=True)

output = ''
blacklist = [
    '[document]',
    'noscript',
    'header',
    'html',
    'meta',
    'head',
    'input',
    'script',
    'body',
    'style',
    'title',
    # there may be more elements you don't want, such as "style", etc.
]

for t in text:
    if t.parent.name not in blacklist:
        output += '{} '.format(t)

print(output)
output = re.sub(r'[\.]{1,50}',' ',output)
output = re.sub(r'[\!]{1,50}',' ',output)
output = re.sub(r'[\,]{1,50}',' ',output)
print(output)
frequency = collections.Counter(output.split())
print(frequency)
print(frequency.most_common(1))
