#!/usr/bin/env python

"""
Example usage:

    python ec2.py get_all_instances '{"tags": {"Name": "Main"}, "state": "running"}'

    python ec2.py get_all_instances '{"public_dns_name": "ec2-40-16-11-93.us-west-1.compute.amazonaws.com"}'

{'_in_monitoring_element': False,
 'ami_launch_index': u'0',
 'architecture': u'x86_64',
 'block_device_mapping': {u'/dev/sda1': <boto.ec2.blockdevicemapping.BlockDeviceType object at 0x1d65a90>,
                          u'/dev/sdh': <boto.ec2.blockdevicemapping.BlockDeviceType object at 0x1d65b50>},
 'clientToken': '',
 'connection': EC2Connection:ec2.us-west-1.amazonaws.com,
 'dns_name': u'ec2-40-16-11-93.us-west-1.compute.amazonaws.com',
 'group_name': None,
 'id': u'i-0318e644',
 'image_id': u'ami-f9b1e322',
 'instanceState': u'\n                    ',
 'instance_class': None,
 'instance_type': u'm1.large',
 'ip_address': u'40.16.11.93',
 'item': u'\n                ',
 'kernel': u'aki-c397c674',
 'key_name': u'mykeyname',
 'launch_time': u'2011-08-12T00:41:20.000Z',
 'monitored': False,
 'monitoring': u'\n                    ',
 'persistent': False,
 'placement': u'us-west-1b',
 'previous_state': None,
 'private_dns_name': u'ip-10-145-34-283.us-west-1.compute.internal',
 'private_ip_address': u'10.145.34.283',
 'product_codes': [],
 'public_dns_name': u'ec2-40-16-11-93.us-west-1.compute.amazonaws.com',
 'ramdisk': None,
 'reason': '',
 'region': RegionInfo:us-west-1,
 'requester_id': None,
 'root_device_name': u'/dev/sda1',
 'root_device_type': u'ebs',
 'shutdown_state': None,
 'spot_instance_request_id': None,
 'state': u'running',
 'state_code': 16,
 'state_reason': None,
 'subnet_id': None,
 'tags': {u'Name': u'my name',
          u'environment': u'qa',
          u'owner': u'jeff',
          u'purpose': u'my purpose'},
 'virtualizationType': u'paravirtual',
 'vpc_id': None}

"""
import sys
from pprint import pprint

import boto
import boto.ec2
import boto.ec2.instance
import simplejson


def main():
    """
    method_name: the boto EC2 connection method to call
    filt: string of json to filter by
    output: comma separated list of keys to output
    """
    method_name = sys.argv[1]
    filt = sys.argv[2]
    filt = simplejson.loads(filt)
    # output = sys.argv[3]
    # output = [val.strip() for val in output.split(',')]
    output = ['public_dns_name', 'private_dns_name', 'instance_type', 'tags', 'launch_time', 'state']

    conn = boto.ec2.connect_to_region('us-west-1')
    method = getattr(conn, method_name)
    result = method()
    _process_result(result, output, filt)


def _process_result(result, output, filt):
    if isinstance(result, list):
        for item in result:
            _process_result(item, output, filt)
    elif isinstance(result, boto.ec2.instance.Reservation):
        for instance in result.instances:
            _process_result(instance, output, filt)
    elif isinstance(result, boto.ec2.instance.Instance):
        if _dict_in_dict(filt, result.__dict__):
            pprint(_keep_only(result.__dict__, output))
    else:
        print 'No handler has been set up for ', type(result)


def _dict_in_dict(dict1, dict2):
    """Test if dict1 is a subset of dict2
    """
    for k in dict1:
        v1 = dict1.get(k)
        v2 = dict2.get(k)
        if not v2:
            return False
        if isinstance(v1, dict):
            result = _dict_in_dict(v1, v2)
        elif isinstance(v1, list):
            result = sorted(v1) == sorted(v2)
        elif isinstance(v1, str):
            result = v1 in v2
        else:
            print 'Error'
            print v1
            print v2
        if not result:
            return False
    return True


def _keep_only(thedict, keys_to_keep):
    """Keep only the specified keys of thedict
    """
    all_keys = thedict.keys()
    for k in all_keys:
        if k not in keys_to_keep:
            del thedict[k]
    return thedict


if __name__ == '__main__':
    main()
