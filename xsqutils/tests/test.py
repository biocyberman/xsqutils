__author__ = 'vql'

import unittest
import logging
logging.basicConfig(level=logging.DEBUG)

bases = '0123'
wildcard = '.'
FAILED_BASE_SCORE = 63

locations = [(2,1525),(2,5008),(3,598),(3,2009),(3,4762),(4,1355),(4,2315),(4,3168),(4,3778),(4,4656),(5,678)]
basequal_list = [[252,59,127,120,56,56],
             [86,59,127,127,86,109],
             [68,252,124,118,58,127],
             [58,38,57,105,57,121],
             [108,70,59,120,105,115],
             [124,57,124,124,92,126],
             [126,68,125,127,84,124],
             [96,106,125,124,127,126],
             [125,102,125,125,127,111],
             [125,126,84,113,59,126],
             [112,58,126,124,110,118]]

def _convert_base(_b):
    qual_raw = _b >> 2
    call, qual = (bases[_b & 0x03], chr(qual_raw + 33 )) if qual_raw != FAILED_BASE_SCORE else (wildcard, chr(33))
    return call, qual


class MyTestCase(unittest.TestCase):

    def test_convert_base(self):
        self.assertEqual(_convert_base(252),('.', '!'))
    def test_convert_zip(self):
        log = logging.getLogger('convert_zip')
        for (y, x), basequals in zip(locations, basequal_list):
            name = '%s_%s_%s%s' % (1, y, x, '_F3')
            calls, quals = zip(*[_convert_base(byte) for byte in basequals])
            log.debug("Calls: %s"%''.join(calls))
            log.debug("Quals: %s"%''.join(quals))
        self.assertEquals(True, True)


if __name__ == '__main__':
    unittest.main()
