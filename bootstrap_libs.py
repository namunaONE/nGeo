# -*- coding: utf-8 -*-
import json, os, urllib.request, zipfile

os.makedirs('_libs', exist_ok=True)
os.makedirs('_wheels3', exist_ok=True)

wanted = {
    'matplotlib': ('cp312', 'win_amd64'),
    'contourpy': ('cp312', 'win_amd64'),
    'fonttools': ('cp312', 'win_amd64'),
    'kiwisolver': ('cp312', 'win_amd64'),
    'cycler': ('py3-none-any', None),
    'packaging': ('py3-none-any', None),
    'pyparsing': ('py3-none-any', None),
    'pymupdf': ('cp311-abi3', 'win_amd64'),
}

for pkg, (tag, plat) in wanted.items():
    j = json.load(urllib.request.urlopen(f'https://pypi.org/pypi/{pkg}/json', timeout=60))
    print(pkg, j['info']['version'])
    cand = None
    for u in j['urls']:
        fn = u['filename']
        if not fn.endswith('.whl'):
            continue
        if tag in fn and (plat is None or plat in fn):
            cand = u
            break
    if not cand:
        print('  NO WHEEL', pkg)
        continue
    fn = os.path.join('_wheels3', cand['filename'])
    urllib.request.urlretrieve(cand['url'], fn)
    with zipfile.ZipFile(fn) as z:
        z.extractall('_libs')
    print('  extracted', cand['filename'], os.path.getsize(fn))
