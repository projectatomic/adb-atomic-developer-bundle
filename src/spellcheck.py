#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Copyright © 2015  Praveen Kumar <kumarpraveen.nitdgp@gmail.com>
#
# This copyrighted material is made available to anyone wishing to use,
# modify, copy, or redistribute it subject to the terms and conditions
# of the GNU General Public License v.2, or (at your option) any later
# version.  This program is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY expressed or implied, including the
# implied warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR
# PURPOSE.  See the GNU General Public License for more details.  You
# should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation,
# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
#


# Usage python spellcheck.py <folder/file path>

"""
Sample Usage:
$ python spellcheck.py ../docs/
+128 ../docs/installing.rst : scl
Output format:
    +<line_number> <file_name> <misspelled_word>
If you use vim then directly copy/paste `vim +<line_number> <file_name>` and you
correct misspelled word fast.
You can add word to validwords file so it will added to custom dictionary which
passed to SpellChecker
"""

import os
from argparse import ArgumentParser
from enchant import DictWithPWL
from enchant.checker import SpellChecker

my_dict = DictWithPWL("en_US", "adb.dict")
checker = SpellChecker(my_dict)
file_extension = ['.md', '.txt', '.rst']

def list_files(rootdir):
    file_list = []
    for root, subdirs, files in os.walk(rootdir):
        for name in files:
            if os.path.splitext(name)[-1] in file_extension:
                file_list.append(os.path.join(root, name))
    return file_list

def check_spell(file_name):
    with open(file_name) as fh:
        for num, line in enumerate(fh, 1):
            checker.set_text(line)
            for err in checker:
                print "+%d %s : %s" % (num, file_name, err.word)

if __name__ == '__main__':
    parser = ArgumentParser(description='Spell checks using en_US dictionary')
    parser.add_argument('path', type=str,
                        help='Provide absoulte path of file/folder to spellcheck')
    args = parser.parse_args()
    file_list = list_files(args.path)
    for file_path in file_list:
        check_spell(file_path)
