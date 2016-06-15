#!/usr/bin/env python
"""
Convert a json file from snake_case to camelCase.

Usage: python camel.py vehicles.json

"""
import json
import sys


def main():
    filename_in = sys.argv[1]
    filename_out = filename_in + '.camel'

    with open(filename_in) as fr:
        with open(filename_out, 'w') as fw:
            json_in = fr.read()
            data = json.loads(json_in)
            camel_cased_data = data_to_camel(data)
            json_out = json.dumps(
                camel_cased_data, indent=2, separators=(',', ': '), sort_keys=True)
            fw.write(json_out)


def data_to_camel(data):
    if isinstance(data, dict):
        return {string_to_camel(k): data_to_camel(v) for k, v in data.items()}
    elif isinstance(data, list):
        return [data_to_camel(x) for x in data]
    else:
        return data


def string_to_camel(snake_str):
    """From http://stackoverflow.com/a/19053800/101911"""
    components = snake_str.split('_')
    return components[0] + "".join(x.title() for x in components[1:])


if __name__ == '__main__':
    main()
