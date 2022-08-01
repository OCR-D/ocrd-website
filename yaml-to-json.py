#!env python3

from yaml import safe_load
from json import dumps
from click import command, argument, option

@command()
@option('--indent', default=2, type=int)
@argument('src')
@argument('dst')
def cli(src, dst, indent):
    kwargs = {}
    if indent > 0:
        kwargs['indent'] = indent
    with open(src, 'r', encoding='utf-8') as f_in, open(dst, 'w', encoding='utf-8') as f_out:
        ret = safe_load(f_in)
        f_out.write(dumps(ret, **kwargs))

if __name__ == '__main__':
    cli()
