#!/usr/bin/env python3
# -*- coding: utf-8 -*-

######################################################################
# Tools
######################################################################
from os.path import join, dirname
import sys
from pathlib import Path

Z01 = str(Path.home()) + '/Z01-Tools/'
sys.path.insert(0, Z01 + 'scripts/')
from config import *

class tstHW(object):

    def __init__(self):
        self.pwd = os.path.dirname(os.path.abspath(__file__))
        self.rtl = os.path.join(self.pwd, 'src/')
        self.tst = os.path.join(self.pwd, '')
        self.log = os.path.join(TOOL_PATH,'log','logS.xml')
        self.work = vhdlScript(self.log)

    def addSrc(self, work):
        work.addSrc(self.rtl)
        work.addSrc(str(Path.home())+ '/Z01-Tools/ref/' )

    def addTst(self, work):
        if work.addTstConfigFile(self.tst) is False:
            sys.exit(1)

    def add(self, work):
        self.addSrc(work)
        self.addTst(work)

if __name__ == "__main__":

    # inicializa notificacao
    noti = notificacao('Simulado')
    tst = tstHW()
    tst.add(tst.work)
    if tst.work.run() is -1:
        noti.error('\n Erro de compilação VHDL')
        sys.exit(-1)

    print("===================================================")
    r = report(tst.log, 'S', 'HW')

    # notificacao / log do teste
    noti.hw(r)
