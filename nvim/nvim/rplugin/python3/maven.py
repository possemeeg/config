#!/usr/bin/python3

import neovim
import subprocess
import re
import sys
import os
from os import path

sys.path.append(path.dirname(path.realpath(path.join(os.getcwd(), path.expanduser(__file__)))))
from util import NvimPlugin

MVN_ERROR_REGEX = re.compile(r'^\[(ERROR|INFO|WARNING)\]\s+([^:\[]+):*\[([0-9]+),([0-9]+)\]\s*(.*)$')
MVN_END_OF_OUTPUT_REGEX = re.compile(r'^\[INFO\]\s+BUILD FAILURE\s*$')

@neovim.plugin
class MavenPlugin(NvimPlugin):
    def __init__(self, nvim):
        super(MavenPlugin,self).__init__(nvim)

    @neovim.command('Mbuild')
    def mbuild(self):
        def _jmvn(param):
            mvn_out = []
            self.echo('building')
            result = self.build(lambda sev, file, line, col, msg:
                    mvn_out.append({'type': sev[0:1], 'lnum': line, 'filename':file, 'col': col, 'valid': 1, 'vcol': 0,
                        'nr': -1, 'type': '', 'pattern': '', 'text': '{}: {}'.format(sev, msg)}))
            self.nvim.funcs.setqflist(mvn_out)
            if result != 0:
                self.nvim.command('copen')
                self.echo('build ready')
            else:
                self.echo('build success')

        self.nvim.async_call(_jmvn, 'self')

    def build(self, callback):
        completed_proc = subprocess.run(['mvn', '--batch-mode', 'clean', 'install'],stderr=subprocess.STDOUT,stdout=subprocess.PIPE,encoding="utf-8")
        for line in completed_proc.stdout.splitlines():
            if MVN_END_OF_OUTPUT_REGEX.match(line):
                break
            self._maven_extract(line, callback) 
        return completed_proc.returncode

    def _maven_extract(self, line, callback):
        match = MVN_ERROR_REGEX.match(line)
        if match:
            callback(match.group(1), match.group(2), match.group(3), match.group(4), match.group(5))

